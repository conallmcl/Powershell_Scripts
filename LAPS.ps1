Get-ADComputer INSERT PC HOSTNAME -Server INSERT SERVER DOMAIN NAME -Properties * | select -ExpandProperty ms-Mcs-AdmPwd
#Pull a Local Administrator Password (LAPS) for machine from Active Directory domain specified
