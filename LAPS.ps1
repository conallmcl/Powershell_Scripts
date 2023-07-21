Get-ADComputer INSERT PC HOSTNAME -Server UKbelDC01V.CONCENTRIX.COM -Properties * | select -ExpandProperty ms-Mcs-AdmPwd
#Pull a Local Administrator Password (LAPS) for machine from Active Directory domain specified
