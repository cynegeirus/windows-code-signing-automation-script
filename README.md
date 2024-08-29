# Windows Code Signing Automation Script

This repository contains a PowerShell script that automates the process of creating a Code Signing Certificate Authority (CA) and a code-signing certificate, converting the certificate to a PFX file, and signing an executable with it. The script also verifies the signature after signing.

## Prerequisites

Ensure the following tools are installed on your system:
- **MakeCert**: Part of the Windows SDK (located in `C:\Program Files (x86)\Windows Kits\10\bin\10.0.19041.0\x64`)
- **SignTool**: Included with the Windows SDK
- **Pvk2Pfx**: Part of the Windows SDK
- **CertUtil**: Available on Windows by default

You can download and install the Windows SDK from the [Microsoft website](https://developer.microsoft.com/en-us/windows/downloads/windows-sdk/).

## How to Use

1. **Clone or download this repository** to your local machine.
2. **Open PowerShell as Administrator** to ensure you have the necessary permissions.
3. Navigate to the directory where the `sign_code.ps1` script is located.
4. Run the script:

   ```powershell
   ./sign_code.ps1
   ```

5. The script will prompt you for the following information:
   - Path to save certificates and signed files (e.g., `C:\SignCode`)
   - Name for the CA certificate (e.g., `COMPANY_CA`)
   - Name for the code-signing certificate (e.g., `COMPANY_SPC`)
   - Name of the executable to sign (e.g., `Example.exe`)
   - Email for the certificate (e.g., `info@company.com`)
   - Timestamp server URL (e.g., `http://timestamp.sectigo.com`)

6. Once the process is completed, the signed executable will be saved in the specified directory, and the script will open that directory automatically.

## Script Details

The PowerShell script performs the following tasks:
1. **Creates a self-signed CA certificate** using MakeCert.
2. **Adds the CA certificate** to the Root certificate store.
3. **Creates a code-signing certificate** signed by the CA.
4. **Converts the code-signing certificate and private key** to a PFX file using Pvk2Pfx.
5. **Signs the specified executable** with the PFX certificate using SignTool.
6. **Verifies the signature** of the signed executable using SignTool.
7. Opens the folder containing the certificates and signed executable for easy access.

## License

This project is licensed under the [MIT License](LICENSE). See the license file for more details.

## Issues, Feature Requests or Support

Please use the Issues section of this repository to submit any issues, feature requests, or support questions. Alternatively, you can contact me directly via e-mail at akin.bicer@outlook.com.tr.

## Example Usage

Here is an example of how the script would run interactively:

```plaintext
Enter the path to save certificates and signed files (e.g., C:\SignCode): C:\SignCode
Enter the name for the CA certificate (e.g., COMPANY_CA): MyCompany_CA
Enter the name for the code-signing certificate (e.g., COMPANY_SPC): MyCompany_SPC
Enter the name of the executable to sign (e.g., Example.exe): MyApp.exe
Enter the email for the certificate (e.g., info@company.com): info@mycompany.com
Enter the timestamp server URL (e.g., http://timestamp.sectigo.com): http://timestamp.sectigo.com
```

After entering the required inputs, the script will complete the process and open the directory containing the signed executable.

---

Thank you for using this repository! If you have any feedback or questions, feel free to reach out.
