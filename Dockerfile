FROM docker.io/oraclelinux:9
LABEL maintainer="Felipe Raposo <feliperaposo@gmail.com>"
RUN curl -o /etc/yum.repos.d/mssql-release.repo https://packages.microsoft.com/config/rhel/9/prod.repo
RUN dnf -y update && \
    ACCEPT_EULA=Y dnf install -y unixODBC postgresql-odbc msodbcsql18 && \
    dnf clean all && \
    rm -rf /var/cache/yum
EXPOSE 7890/tcp
COPY ./root/ /
RUN cat /etc/odbcinst_psql.ini >> /etc/odbcinst.ini && \
    rm -f /etc/odbcinst_psql.ini
CMD ["/dbaccess.sh"]
