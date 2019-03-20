From: jan.kiszka@siemens.com (Jan Kiszka)
Date: Wed, 20 Mar 2019 07:13:49 +0100
Subject: [cip-dev] Testing update + cip-core
In-Reply-To: <OSAPR01MB376397FD0A2ED68453B4D0B7D0410@OSAPR01MB3763.jpnprd01.prod.outlook.com>
References: <OSBPR01MB2055F3150CC418B4FFA7A740E94B0@OSBPR01MB2055.jpnprd01.prod.outlook.com>
	<OSAPR01MB376303BDABB64E54B07645C2D0400@OSAPR01MB3763.jpnprd01.prod.outlook.com>
	<d351d297-c7fc-1e43-2470-d96f5c69a9f8@siemens.com>
	<OSBPR01MB2055DD55592F4E4AC3F794AAE9400@OSBPR01MB2055.jpnprd01.prod.outlook.com>
	<dfb75e5e-f77f-f9db-c088-663bcc667561@siemens.com>
	<OSAPR01MB376397FD0A2ED68453B4D0B7D0410@OSAPR01MB3763.jpnprd01.prod.outlook.com>
Message-ID: <56c21017-d095-cf64-a89d-bddc7c261181@siemens.com>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

On 20.03.19 01:39, daniel.sangorrin at toshiba.co.jp wrote:
>> From: Jan Kiszka <jan.kiszka@siemens.com>
> [..]
>>
>> However, that does not exclude tftp+nfs boot for testing purposes. You will have
>> all needed binaries available along with the self-standing image.
> 
> Jan: is it possible to add tar.gz to IMAGE_TYPE in ISAR? that's an easy format for LAVA to deploy to nfs/nbd.
> 

Yes, you can set that as well (IMAGE_TYPE = "targz-img"). We are using it for 
building containers.

Jan

-- 
Siemens AG, Corporate Technology, CT RDA IOT SES-DE
Corporate Competence Center Embedded Linux
