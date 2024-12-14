#include<stdio.h>
#include<syslog.h>
#include<string.h>

int main(int argc, char **argv)
{
    openlog(NULL, LOG_USER, LOG_DEBUG);
    if(argc < 3)
    {
        printf("Error: Script requires <path_to_file> <content>");
        syslog(LOG_ERR, "Error: Script requires <path_to_file> <content>");
        return 1;
    }

    char *path = argv[1];
    char *content = argv[2];

    FILE *file = fopen(path, "w+");
    if(file == NULL)
    {
        printf("Failed to open file");
        syslog(LOG_ERR, "Failed to open file");
        return 1;
    }

    int len = strlen(content);
    int rc = fwrite(content, sizeof(char), len, file);
    if(rc < len)
    {
        syslog(LOG_ERR, "File write error");
        return 1;
    }
    char print_buf[50] = {0};
    sprintf(print_buf, "Writing %s to %s\n", content, path);
    syslog(LOG_DEBUG, &print_buf[0]);
    printf(&print_buf[0]);
    closelog();

    return 0;
}