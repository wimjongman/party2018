/********************************************************************/
/*                                                                  */
/* Function OMS_NormName() normalizes an IFS-objectname:            */
/*                                                                  */
/* 1. Consecutive slashes and backslashes are replace by one slash. */
/* 2. A trailing slash is removed.                                  */
/* 3. If the filesystem containing the object is not case-sensitive */
/*    the name is translated to uppercase.                          */
/* 4. The value of errno is returned if an error occurs, otherwise  */
/*    the value zero is returned.                                   */
/*                                                                  */
/* Example: /\/\\//QdlS\\\/abc.TXT     -->  /QDLS/ABC.TXT           */
/*          /\/\/QOpenSys\\\/abc.Txt   -->  /QOpenSys/abc.Txt       */
/*                                                                  */
/* QOpenSys is case-sensitive, QDLS is not.                         */
/*                                                                  */
/********************************************************************/

#include <sys/statvfs.h>
#include <stdio.h>
#include <string.h>
#include <ctype.h>
#include <errno.h>

void strtoupper(char *p);
int statvfs(const char *path, struct statvfs *buf);
int OMS_NormName(char *pathout, char * pathin);

int OMS_NormName(char *pathout, char * pathin)
{
 int i, j, rc;
 struct statvfs info;
 int skipchar;
 char filesystem[257];
 char upper_filesystem[257];
 char upper_f_basetype[80];
 char *p;

 /* Replace combinations of consecutive '/' and '\' by '/'  */

 skipchar = 0;
 i = 0;
 j = 0;
 while(pathin[i])
    {
     if(pathin[i] == '/' || pathin[i] == '\\') {
         if(!skipchar) {
            pathout[j] = '/';
            j++;
         }
         skipchar = 1;
       }
     else {
       pathout[j] = pathin[i];
       j++;
       skipchar = 0;
       }
     ++i;
     }
 if((j>1) && (pathout[j-1] == '/')) /* remove trailing slash */
   j--;
 pathout[j] = '\0';

  /* Get the first directory in the path. This could be the          */
  /* filesystem. File systems are always in the root directory.      */
  /* Change the second slash in the path to a '\0' and the first     */
  /* directory is found.                                             */

  strcpy(filesystem, pathout);
  if(strlen(filesystem) > 1) {
    p=strchr(&filesystem[1], '/');
    if(p)
      *p = '\0';
  }

  /* Get information about the filesystem. If the directory does not */
  /* exist, it is not a filesystem, so the root is the filesystem.   */
  /* The proper name of the filesystem is copied into the path.      */

  rc = statvfs(filesystem, &info);
  if((rc == -1) && (errno == ENOENT)) {
     strcpy(filesystem, "/");
     rc = statvfs(filesystem, &info);
  }
  if(rc == -1)
    return errno;

/* info.f_basetype can contain the properly capitalized name for  */
/* the filesystem like 'QOpenSys', or some other text like        */
/* 'NETWORK FILE SYSTEM ...'.                                     */
/* info.f_basetype and filesystem are converted to uppercase. If  */
/* they are equal, filesystem is replaced by info.f_basetype.     */

  strcpy(upper_f_basetype, info.f_basetype);
  strtoupper(upper_f_basetype);

  strcpy(upper_filesystem, filesystem);
  strtoupper(upper_filesystem);

  if(!(strcmp(upper_f_basetype, upper_filesystem)))
     memcpy(pathout, info.f_basetype, strlen(info.f_basetype) );

  /* Convert the path to uppercase if the filesystem is not          */
  /* case-sensitive.                                                 */

  if( ! (info.f_flag & ST_CASE_SENSITIVE) )
     strtoupper(pathout);

  return 0;
 }

void strtoupper(char *p)
{
     while(*p++)
           *p = toupper(*p);
}
