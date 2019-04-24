From: SZ.Lin@moxa.com (=?utf-8?B?U1ogTGluICjmnpfkuIrmmbop?=)
Date: Wed, 24 Apr 2019 06:47:27 +0000
Subject: [cip-dev] [cip-core] RFC: Process to decide supported package
 list
In-Reply-To: <TYAPR01MB50051E633D3AFF11DCC34A3ADF220@TYAPR01MB5005.jpnprd01.prod.outlook.com>
References: <OSBPR01MB277402D6349598D10F48A165E1240@OSBPR01MB2774.jpnprd01.prod.outlook.com>
	<CAFk6z8OJW9k+YEs3cp-MzYN_428w5KHDFpRkiCjB0zzhQTdpWg@mail.gmail.com>
	<TYAPR01MB50051E633D3AFF11DCC34A3ADF220@TYAPR01MB5005.jpnprd01.prod.outlook.com>
Message-ID: <HK0PR01MB297913CB4BB27D2D2664DCBFE23C0@HK0PR01MB2979.apcprd01.prod.exchangelabs.com>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

Hi,
> -----Original Message-----
> From: Kento Yoshida <kento.yoshida.wz@renesas.com>
> Sent: Monday, April 22, 2019 11:05 AM
> To: SZ Lin (???) <SZ.Lin@moxa.com>; Kazuhiro HAYASHI
> <kazuhiro3.hayashi@toshiba.co.jp>; Takehisa Katayama
> <takehisa.katayama.bx@renesas.com>
> Cc: cip dev <cip-dev@lists.cip-project.org>
> Subject: RE: [cip-dev] [cip-core] RFC: Process to decide supported package list
> 
> Hello Lin-san,
> 
> > Would you like to add some essential security packages into a list based on
> security workgroup discussion?
> Yes we would.
> We may add more packages in near future discussions, but at least the
> following packages should be added into the list.
> 
> openssl
> sudo
> 
> *acl, pam and shadow have already listed.
> **auditd is included into "audit" that has already listed.
> ***openssh is considered to add into the list by WG.
> ****tpm2-tools is not mandatory, but you may add into the list as an optional
> choice for customers.
> 
> Is there anything else?

LGTM, thank you!

SZ

> 
> Best regards,
> Kent Yoshida
> 
> -----Original Message-----
> From: SZ Lin (???) <sz.lin@moxa.com>
> Sent: Monday, April 22, 2019 11:30 AM
> To: Kazuhiro HAYASHI <kazuhiro3.hayashi@toshiba.co.jp>; Takehisa Katayama
> <takehisa.katayama.bx@renesas.com>; Kento Yoshida
> <kento.yoshida.wz@renesas.com>
> Cc: cip dev <cip-dev@lists.cip-project.org>
> Subject: Re: [cip-dev] [cip-core] RFC: Process to decide supported package list
> 
> Hi,
> 
> <kazuhiro3.hayashi@toshiba.co.jp> ? 2019?4?16? ?? ??9:22
> ???
> >
> > Hello CIP developers,
> >
> > I would like to suggest an idea about the process to determine the package
> list that should be supported by CIP.
> > It's difficult to discuss adding any packages including their dependencies
> from whole Debian, mixing the two profiles.
> >
> 
> Thanks for your work, Hayashi-san.
> 
> Hi Katayama-san and Yoshida-san,
> 
> Would you like to add some essential security packages into a list based on
> security workgroup discussion?
> 
> SZ
