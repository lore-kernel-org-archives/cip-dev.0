From: patryk.mungai-ndungu.kx@renesas.com (Patryk Mungai Ndungu)
Date: Wed, 20 Mar 2019 09:17:41 +0000
Subject: [cip-dev] Testing update + cip-core
In-Reply-To: <OSAPR01MB376397FD0A2ED68453B4D0B7D0410@OSAPR01MB3763.jpnprd01.prod.outlook.com>
References: <OSBPR01MB2055F3150CC418B4FFA7A740E94B0@OSBPR01MB2055.jpnprd01.prod.outlook.com>
	<OSAPR01MB376303BDABB64E54B07645C2D0400@OSAPR01MB3763.jpnprd01.prod.outlook.com>
	<d351d297-c7fc-1e43-2470-d96f5c69a9f8@siemens.com>
	<OSBPR01MB2055DD55592F4E4AC3F794AAE9400@OSBPR01MB2055.jpnprd01.prod.outlook.com>
	<dfb75e5e-f77f-f9db-c088-663bcc667561@siemens.com>
	<OSAPR01MB376397FD0A2ED68453B4D0B7D0410@OSAPR01MB3763.jpnprd01.prod.outlook.com>
Message-ID: <OSBPR01MB2055BB21A8D9E5124E32DDCAE9410@OSBPR01MB2055.jpnprd01.prod.outlook.com>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

Hello Daniel,

> -----Original Message-----
> From: daniel.sangorrin at toshiba.co.jp <daniel.sangorrin@toshiba.co.jp>
> Sent: 20 March 2019 00:39
> To: jan.kiszka at siemens.com; Patryk Mungai Ndungu <patryk.mungai-
> ndungu.kx at renesas.com>
> Cc: cip-dev at lists.cip-project.org
> Subject: RE: [cip-dev] Testing update + cip-core
> 
> > From: Jan Kiszka <jan.kiszka@siemens.com>
> [..]
> >
> > However, that does not exclude tftp+nfs boot for testing purposes. You
> will have
> > all needed binaries available along with the self-standing image.
> 
> Jan: is it possible to add tar.gz to IMAGE_TYPE in ISAR? that's an easy format
> for LAVA to deploy to nfs/nbd.
> 
> Patryk: from the documentation it seems that nbdroot supports the raw
> image format. Could you confirm?
> https://staging.validation.linaro.org/static/docs/v2/actions-
> deploy.html#nbdroot
> nbdroot:
>       url: http://fix.me/rootfs.ext4.xz <-- this is probably just a raw image
> compressed
> 

I've not had a chance to play around with NBD yet, but this looks to be the case.
Let me know if you?d like me to look into adding NBD support for the lab in Renesas.

Thanks,
Patryk

> Thanks,
> Daniel
