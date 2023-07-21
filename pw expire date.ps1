Add-Type -AssemblyName System.Windows.Forms

# Create a form
$form = New-Object System.Windows.Forms.Form
$form.Text = "Check Password Expiration"
$form.Width = 400
$form.Height = 200
$form.StartPosition = "CenterScreen"

# Create a label for the username
$usernameLabel = New-Object System.Windows.Forms.Label
$usernameLabel.Location = New-Object System.Drawing.Point(20,20)
$usernameLabel.Size = New-Object System.Drawing.Size(100,20)
$usernameLabel.Text = "Username:"
$form.Controls.Add($usernameLabel)

# Create a textbox for the username
$usernameTextbox = New-Object System.Windows.Forms.TextBox
$usernameTextbox.Location = New-Object System.Drawing.Point(130,20)
$usernameTextbox.Size = New-Object System.Drawing.Size(200,20)
$form.Controls.Add($usernameTextbox)

# Create a button to check the password expiration date
$checkButton = New-Object System.Windows.Forms.Button
$checkButton.Location = New-Object System.Drawing.Point(20,50)
$checkButton.Size = New-Object System.Drawing.Size(310,30)
$checkButton.Text = "Check Password Expiration"
$form.Controls.Add($checkButton)

# Create a label to display the password expiration date
$passwordExpirationLabel = New-Object System.Windows.Forms.Label
$passwordExpirationLabel.Location = New-Object System.Drawing.Point(20,90)
$passwordExpirationLabel.Size = New-Object System.Drawing.Size(310,40)
$form.Controls.Add($passwordExpirationLabel)

# Add an event handler to the button
$checkButton.Add_Click({
    # Get the domain name
    $domain = Get-WmiObject Win32_ComputerSystem | Select-Object Domain

    # Get the username from the textbox
    $username = $usernameTextbox.Text

    # Get the user's account information
    $user = Get-ADUser -Identity $username -Properties "DisplayName", "msDS-UserPasswordExpiryTimeComputed"

    # Calculate the password expiration date
    $pwdExpirationDate = [datetime]::FromFileTime($user."msDS-UserPasswordExpiryTimeComputed")

    # Get the current date and time
    $currentDate = Get-Date

    # Calculate the number of days until the password expires
    $daysUntilExpiration = ($pwdExpirationDate - $currentDate).Days

    # Display the password expiration date and the number of days until it expires
    $passwordExpirationLabel.Text = "Password expiration date: $pwdExpirationDate`nDays until password expiration: $daysUntilExpiration"
})

# Show the form
$form.ShowDialog() | Out-Null
