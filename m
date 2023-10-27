Return-Path: <quirin.gylstorff@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B590C25B47
	for <webhook@archiver.kernel.org>; Fri, 27 Oct 2023 14:52:07 +0000 (UTC)
Received: from EUR04-VI1-obe.outbound.protection.outlook.com (EUR04-VI1-obe.outbound.protection.outlook.com [40.107.8.57])
 by mx.groups.io with SMTP id smtpd.web11.8862.1698418321576462921
 for <cip-dev@lists.cip-project.org>;
 Fri, 27 Oct 2023 07:52:02 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@siemens.com header.s=selector2 header.b=BkFhLRgu;
 spf=pass (domain: siemens.com, ip: 40.107.8.57, mailfrom: quirin.gylstorff@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dVC/EAIl27OSC/stJ4R2ZtF7rfChPdrSGDDFIfrNY9fJAdPX0p4LAL+/ZgppR4Au8p3z52HdWDJze9M552sQe4qf0I6F9DJ0SzgO3VnydUZq7kzbArM96VuXNEAovcSDNbEScB7w+Yj246VBcZL1ujwq+FxmfBvEPGRF2NIfXNbDMNVOjtKCCdcq2eGgHd6SN8VN9SvEjbRNaPJqQAwhAZ9seQ0jnwyT1AhkBKPyeHOWeqe31pON0+wZ043y/ct7nMPMiQC2iS1lrg9bLnUpDABv9EYrQ3sVp8PLOEAmC9EkhKSmzEFU7iR+Kd+i+KbGArnRA3UJ69BvnEBbQFJZWw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gzWDzyb2RZ2/QE9Ji8k4Jl8a8xgu3UJ+d+Qphpov7Js=;
 b=IcmM+yWVgnDWUKK5U4m10oUTLMh/11Lz9BaDzwl4h+xajJlL2QFamjIaEGGbdK1iB5EiYSha8rlXRCldT5OJ37hsdnKqfg0GHyhDWcklPHNI7kOYB3aC4PnSrOr24GxMObH+cXYQw0nLFmhNdPBpEP7aRoIQp3ZLRbq6T57tJUigMLYLReqKevU4ZYtDnZ61dSJWvc9vW5C2qB2iXn4xNLC38+tbF/aXbuHXfemG4cS6Mp5EAwo5/HHlvWdBhzEY1ONOx3yxbCrHkhteFyml8FgF/B3t/oAt6JTIFSFidbotWpPLWcRPzGhbIURjjUx2hmCkaearKSUZaMfTDMGrEw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gzWDzyb2RZ2/QE9Ji8k4Jl8a8xgu3UJ+d+Qphpov7Js=;
 b=BkFhLRgucc/VFhJn8bWeqqcDenMdjtmkiZqJc94feAP/ntQwe5p9LDVZepaxeBNdjQZdHnWKcW/gGzRhcJypGsMUJRRwl+KIrVhtmmGlXZ3zYyR+Q7nL1aBkYFANBzeQ/yn+GRnpz2DfLwoxTJ4UOr3AwL4R1vXtwVq0AY3vkLiSMVk9ECSnMFrbcF3KSEithmO/siwYsSFd+z3yh2m8GGlSqHrqxAThrXPxl4oJFgvmK4fdm4xvuuXEUsafLqhPxop6lbDEB3mgIsvG5SlzhA8j1egWKMVoABoCLhRH+0XRw8HVpOQU9wr7V5W1Mb6jO81ml+c7RXvBMd6gqaOA+g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AM9PR10MB4085.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:1f9::22)
 by AS2PR10MB7851.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:645::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6933.23; Fri, 27 Oct
 2023 14:51:58 +0000
Received: from AM9PR10MB4085.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::5d28:13c2:1583:fabc]) by AM9PR10MB4085.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::5d28:13c2:1583:fabc%6]) with mapi id 15.20.6933.019; Fri, 27 Oct 2023
 14:51:58 +0000
Message-ID: <97ee33c6-7bcc-4a76-ae24-40dcda09cdab@siemens.com>
Date: Fri, 27 Oct 2023 16:51:52 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [cip-dev][isar-cip-core][RFC 7/9] cip-core-image-security: Move
 packages to security-customization
Content-Language: en-US, de-DE
To: Venkata.Pyla@toshiba-tsip.com, jan.kiszka@siemens.com,
 cip-dev@lists.cip-project.org, dinesh.kumar@toshiba-tsip.com,
 kazuhiro3.hayashi@toshiba.co.jp
References: <20231023150243.3990309-1-Quirin.Gylstorff@siemens.com>
 <20231023150243.3990309-8-Quirin.Gylstorff@siemens.com>
 <OS3PR01MB68561590E077CB11799AA56FA4DDA@OS3PR01MB6856.jpnprd01.prod.outlook.com>
From: Gylstorff Quirin <quirin.gylstorff@siemens.com>
Autocrypt: addr=quirin.gylstorff@siemens.com; keydata=
 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
 XSdq0hnpafc1V+voPJq3LMxUvLNrwg==
In-Reply-To: <OS3PR01MB68561590E077CB11799AA56FA4DDA@OS3PR01MB6856.jpnprd01.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: CH2PR04CA0018.namprd04.prod.outlook.com
 (2603:10b6:610:52::28) To AM9PR10MB4085.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:1f9::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR10MB4085:EE_|AS2PR10MB7851:EE_
X-MS-Office365-Filtering-Correlation-Id: c8a8796e-252c-4959-dc46-08dbd6fc44e7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	Zv3CxCRUh1KX4nd+IhCINlGNeZfLVkPj5l0FIrvOWQNb7OJOVY1JkL/F3AzXiyaIavbocbDasUzlXe3F6UWdvDJSVBISS9d95YPn5aSq5fZYvYFdHQyrM1PB+4XuUgmDzotaFVBJKgHa9KfkHFelEL3icEvKAv1J5i8SW0Pt/aGjfO0+i6yM0YEN5ZcrbcNoyGHWb05vo4IINLWQMtRxWzURIOnDSq0J1NcZttiDtIF4jc+9TmE+iYuif7KsOnElDLAD6PUCWwwEf0cBfyjcpaqdb3OvQsh/050QFricjyOQcm7K3lZTQGz5aXZpD5ouEMztb/m5Bcv/VC+RBLrszCEtUirS9jgOwKjE+6chI51P5TLgBG1yY7GsvaH1ViV4jhuMEec2XH1Q7pb39m16x+z58DBwlE8fObOsjwo2vliIeISBqda1esGDb0mrV54A4/cJoZfOPlKj0cY7pbR+3R9auGcD3Zi4dKlrQhw+FV1g/NvWCaGbgnWKPDQ0bWSWpYP2qVjRYEzRkkXMpxBZQEPbulvkGo8dQTqycZ5pVKBY0bdDOlX1E34qd415dYGRXN8Cltopd9ESAzejSGfVz9qETRzVwVLANtlPoeYWI6cd4cWY1GXM0J2hG9eYRI8au23pAv+ixxIuMvt7jKySPQ==
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR10MB4085.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(366004)(136003)(346002)(376002)(396003)(230922051799003)(186009)(451199024)(64100799003)(1800799009)(53546011)(478600001)(6666004)(6486002)(6506007)(36756003)(2616005)(82960400001)(26005)(6512007)(38100700002)(83380400001)(15650500001)(2906002)(5660300002)(41300700001)(31696002)(8676002)(8936002)(86362001)(31686004)(66476007)(66946007)(316002)(66556008)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?2i6EBFNHVjLoqpPoJCF0c8dYP81gJa2br0/nImUzXnBowHVykuaoZNdVepQK?=
 =?us-ascii?Q?21GWZKvbPBFXz2x7zL5J00biAyS1/XYD9Ps8Y075LDG2N9XNeJxKCLOi2rMI?=
 =?us-ascii?Q?I6Z7mi+Vq3/7NIQRViD4V8TMCWBwl7Kgmvh2PwFXMVLSLnBq4Boyz3L/kepp?=
 =?us-ascii?Q?l6t6BSwJ0BDEjkNwfbJ59KdG2+gsASL4Ax6GIVPYY+Z2uxAfp1vwbJvClbZa?=
 =?us-ascii?Q?8CJd7s3Pm58lttFS0DMa1vI3H7+sTAplDfH4UYXM3CrwacVpfT41AIQQvprr?=
 =?us-ascii?Q?fakWmFZ9BphxCEK6Mlc1BkHysDOoW1bArJ9slW8WjzamZNWzK2lv1XI0Fd4W?=
 =?us-ascii?Q?Y0rzE16h+ZToJN3CwNcSwgcn6HAwDiLPRW0LQ2aTR2zjMC02QZEwD9N9EX9K?=
 =?us-ascii?Q?sXPCo03MqfhBezgRBgpBB3cDYMME2+HBXwLXXa1rw1G64dCCc/3C/N9KVOET?=
 =?us-ascii?Q?7ETgehC6ofGmPJhMGIH+IZ7DcrimG/LeFFB2cY5QzP/Tz9HA0XTqjTAidtmS?=
 =?us-ascii?Q?tLbGQrI0MRtPMPRJbVrwYO59Vu84xx/TyfSDnr6P3G5j9dqbuBHDrvvwWOh9?=
 =?us-ascii?Q?AXPnGKJ5XutuzhBonCt8im1t0q3iqDaAi3H5zZPPOdhmzHPIwAhwSccG14/9?=
 =?us-ascii?Q?2OIquCEMMXjUdJ0Kc2agdFjlrE2JQjjqo4pDjlIFLfWXHdtLumr4OSrVCLRx?=
 =?us-ascii?Q?ixVtTc+Jg1XmEkYj3dtQoYTtkTQ7r9xi01q4ruSyo7VLBhSfvG/iMIPfw9cp?=
 =?us-ascii?Q?vUTikV7aVaBrTP2zTDrXU3gI+PrsP4LLi6nDqRRuuuYA91QTUoFLy1wndJ9/?=
 =?us-ascii?Q?mLjzJ1Xh857ORdsUhnjT5lunBGebFz62IyoEF/xfAGsWsliF5dfGx4sC1uGS?=
 =?us-ascii?Q?ZODpfk7dT1nlEK/BCqJ66cyuIiD/qY8XMNazEZb47/AzYLzek7L6M4ITQJsw?=
 =?us-ascii?Q?QYDCuH6D+ybdXSfVU3qV5amRU0jguzb77USluXzA5PeCnuTD7YnM9k0SFy4C?=
 =?us-ascii?Q?p4jtgzbmP78TaaqE7JtUPmPed5qVaHr9ruMpcsDvPPtm4bEVzcUgzqi0UIrd?=
 =?us-ascii?Q?38eEPiLmkew6478Lptb8ph5zUpj6U20QHrwArd6cp6ODlYJcFJ5EnWMxwAh3?=
 =?us-ascii?Q?IfHjDRU89RnFIcHMUAFkIOGPVBH4jbgszQfhnPOxXgVGjYNi7lS79vScbXex?=
 =?us-ascii?Q?OwLDXfbuY1eEDVTX2TMK9ogyXf+3R4jbS1M2W6Sehnw54nWTz1fVhmtVafA8?=
 =?us-ascii?Q?XzViUKnphi0lgO5xQ9Yszy2fxllQfCRrZToXX9TGoFx8I5QqZgsajY1fSRyV?=
 =?us-ascii?Q?oPnHkbAURUxRfQ0HIhaBN8HDV33jD0AV92lcfPGINlXnM3mjmsrm6lfPSWjc?=
 =?us-ascii?Q?FFsGTlHttf/c8BljS1Z78Iu6Ct+6DpWkKMM2L6fguiZe/z6qELFB7kYTCp+F?=
 =?us-ascii?Q?azEcWjj2lSOS9a8WuGJDPhqobGEjufUC/knSdF/tvgbels4bryMso5BRCIQ+?=
 =?us-ascii?Q?4pVSk85Fvfcm35o4R9vlvrVoj9aoPXwGz1VeSxheEqWelPmm6V6/reEa47gg?=
 =?us-ascii?Q?/fpvm+4fZjLjdA47bVvPdhG4FfYcCM9GY7dJqBxaDkjY8BEW09wqsZvZq7WN?=
 =?us-ascii?Q?MA=3D=3D?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c8a8796e-252c-4959-dc46-08dbd6fc44e7
X-MS-Exchange-CrossTenant-AuthSource: AM9PR10MB4085.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Oct 2023 14:51:58.1517
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9O6Ga/ghlrNj6L46axNTwN/ChuxdGdIcWHwZhXtEyvougTxuJaFvoXbD/K+LJT9EzjWs0gpl4FVffwawyfZnWvOf4LUueTPWCZxCpFOWvHQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS2PR10MB7851
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 27 Oct 2023 14:52:07 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/13482



On 10/26/23 06:33, Venkata.Pyla@toshiba-tsip.com wrote:
>=20
>=20
>> -----Original Message-----
>> From: Quirin Gylstorff <Quirin.Gylstorff@siemens.com>
>> Sent: Monday, October 23, 2023 8:30 PM
>> To: jan.kiszka@siemens.com; cip-dev@lists.cip-project.org; pyla
>> venkata(=EF=BC=B4=EF=BC=B3=EF=BC=A9=EF=BC=B0 TMIEC ODG Porting) <Venkata=
.Pyla@toshiba-tsip.com>;
>> dinesh kumar(=EF=BC=B4=EF=BC=B3=EF=BC=A9=EF=BC=B0 TMIEC ODG Porting) <di=
nesh.kumar@toshiba-
>> tsip.com>; hayashi kazuhiro(=E6=9E=97 =E5=92=8C=E5=AE=8F =EF=BC=A4=EF=BC=
=AD=EF=BC=A5 =E2=97=8B=EF=BC=A4=EF=BC=A9=EF=BC=A7=E2=96=A1=EF=BC=AD=EF=BC=
=B0=EF=BC=B3=E2=97=8B=EF=BC=AD=EF=BC=B0=EF=BC=94)
>> <kazuhiro3.hayashi@toshiba.co.jp>
>> Subject: [cip-dev][isar-cip-core][RFC 7/9] cip-core-image-security: Move
>> packages to security-customization
>>
>> From: Quirin Gylstorff <quirin.gylstorff@siemens.com>
>>
>> To ensure that the package security-customizations is installable move
>> packages from cip-core-image-security as dependencies to security-paackg=
es.
Ah typo in the commit message.
>=20
> Thanks for improving this, earlier the security packages are installed at=
 one place to make sure all security packages are installed, later when the=
 security configurations are added, the dependencies are not added.
>  > With this patch the dependencies are well created, the security=20
customizations for which the packages are required are added to=20
DEBIAN_DEPENDS.
> but few packages (libtss2*) which don't have any security customization a=
re also added to security-customizations dependencies, do you want to keep =
this in security-customizations itself ?

The move of libtss2* was due to copy-paste.


I can move it back. But the questions then is why do we install unused=20
library?

>=20
> This is to have understanding that all the security packages that have cu=
stomizations are added with DEBIAN_DEPENDS in security-customizations.bb, a=
nd all other security packages with no customizations are added with IMAGE_=
PREINSTALL in cip-core-image-security.bb,

Yes all package which are modified by security-customizations should be=20
added to DEBIAN_DEPENDS to ensure the installation order.


Best regards,
Quirin

>=20
>>
>> Signed-off-by: Quirin Gylstorff <quirin.gylstorff@siemens.com>
>> ---
>>   recipes-core/images/cip-core-image-security.bb     | 12 +-----------
>>   .../security-customizations.bb                     | 14 +++++++++++---
>>   2 files changed, 12 insertions(+), 14 deletions(-)
>>
>> diff --git a/recipes-core/images/cip-core-image-security.bb b/recipes-
>> core/images/cip-core-image-security.bb
>> index 3421ce5..525a346 100644
>> --- a/recipes-core/images/cip-core-image-security.bb
>> +++ b/recipes-core/images/cip-core-image-security.bb
>> @@ -28,24 +28,14 @@ IMAGE_PREINSTALL +=3D " \
>>   	tpm2-tools \
>>   	tpm2-abrmd \
>>   	acl \
>> -	audispd-plugins auditd \
>> +	audispd-plugins \
>>   	uuid-runtime \
>>   	sudo \
>>   	aide-common \
>> -	libpam-google-authenticator \
>>   	passwd \
>>   	login \
>> -	libpam-runtime \
>>   	util-linux \
>>   "
>>
>> -# Package names based on the distro version -
>> IMAGE_PREINSTALL:append:buster =3D " libtss2-esys0 \
>> -                                   libpam-cracklib"
>> -IMAGE_PREINSTALL:append:bullseye =3D " libtss2-esys-3.0.2-0 \
>> -                                     libpam-cracklib"
>> -IMAGE_PREINSTALL:append:bookworm =3D " libtss2-esys-3.0.2-0 \
>> -                                     libpam-passwdqc"
>> -
>>   CIP_IMAGE_OPTIONS ?=3D ""
>>   require ${CIP_IMAGE_OPTIONS}
>> diff --git a/recipes-core/security-customizations/security-customization=
s.bb
>> b/recipes-core/security-customizations/security-customizations.bb
>> index d3cede8..162d2f6 100644
>> --- a/recipes-core/security-customizations/security-customizations.bb
>> +++ b/recipes-core/security-customizations/security-customizations.bb
>> @@ -11,14 +11,22 @@
>>
>>   inherit dpkg-raw
>>
>> -DESCRIPTION =3D "CIP Security image for IEC62443-4-2 evaluation"
>> +DESCRIPTION =3D "CIP Security configuration for IEC62443-4-2 evaluation=
"
>>
>>   SRC_URI =3D "file://postinst \
>>              file://ssh-remote-session-term.conf \
>>              file://ssh-pam-remote.conf"
>>
>> -DEPENDS =3D "customizations, sshd-regen-keys"
>> -DEBIAN_DEPENDS =3D "customizations , sshd-regen-keys, libpam-google-
>> authenticator"
>> +DEPENDS =3D "customizations sshd-regen-keys"
>> +DEBIAN_DEPENDS =3D "customizations, sshd-regen-keys, libpam-google-
>> authenticator, libpam-modules, libpam-runtime, auditd"
>> +
>> +# Package names based on the distro version
>> +DEBIAN_DEPENDS:append:buster =3D ", libtss2-esys0, \
>> +                                   libpam-cracklib"
>> +DEBIAN_DEPENDS:append:bullseye =3D ", libtss2-esys-3.0.2-0, \
>> +                                     libpam-cracklib"
>> +DEBIAN_DEPENDS:append:bookworm =3D ", libtss2-esys-3.0.2-0, \
>> +libpam-passwdqc"
>>
>>   do_install[cleandirs] +=3D "${D}/etc/ssh/sshd_config.d/"
>>   do_install () {
>> --
>> 2.42.0
>=20

