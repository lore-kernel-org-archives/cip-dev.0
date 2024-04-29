Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD15FC4345F
	for <webhook@archiver.kernel.org>; Mon, 29 Apr 2024 14:18:18 +0000 (UTC)
Received: from EUR04-HE1-obe.outbound.protection.outlook.com (EUR04-HE1-obe.outbound.protection.outlook.com [40.107.7.47])
 by mx.groups.io with SMTP id smtpd.web11.22446.1714400290835883900
 for <cip-dev@lists.cip-project.org>;
 Mon, 29 Apr 2024 07:18:11 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@siemens.com header.s=selector2 header.b=tOVxXGmP;
 spf=pass (domain: siemens.com, ip: 40.107.7.47, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TRq/VULBw/47I5oP/M7ZjKBPeQfRc8W1SRojDGEN/TFC3DP4/K4VvEdGoqwv+dC8jAC4pfLMiqGrr3xuwInSNHmZDQC3AyZIRacz5/ZPhjFDY42/RCBqTD2mdj31npbi+s/39IASoTAFZZKzjUbMsKmn5OcU/LJzJ5lTn9pL52t3S3Hx2JAD1m3gKrV5Rqtm4RYQcvsUHirhURTCZsccXmmhE+0M9Gn6UZQToE5nnpJM0ZB+RjY4WRlEvxi1kQFwUsgWMaIMNhFh3oN7p+h1Iq71i+XJYWjn9XhBuxfyCxgqtzCV4KY6398f2P1sCRysHLmZzUJFjD29dLAZY2071Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sAck42iGElOmx7l3LkVJV9Oe7MXCH250EAGSF1hlEbg=;
 b=R9Bp+jr6cwyThuXwKTRCW170Jrn+4dhvJzbg2cfkN6QALKzMf6fcApfJkr4qQJzTyeC3RWeyk81LnY734DDVh1jrXmIeKIqI5izDa1kkvaDGBKgbuiBTYTUiEtC5IgvYgi4eZUZXzNsjghPUVVOFLGLxqPl8zQaTFd8gpfgy9j7T6LInVv7dTD4vQATpcYQ6maADyw6Yi/WgAn1opsghVknlHBj2orR4Gc73HebdXJ4bNWeIFKCq9vR1hj29pQRz8Q2TUCAgI+znP8L3Q2t0SiI7mH5qRPIm13FV2+gFpo3sQDeEUpASg59gT9xCOB2Hc/I+Zfbyu/ihwHKvES/x/Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sAck42iGElOmx7l3LkVJV9Oe7MXCH250EAGSF1hlEbg=;
 b=tOVxXGmPtfdn059He8vQAiqQ7A+NveDja6l8YkLUPdYo6hAmJWve+rJbVMbLK28qWYgk7fDaaiI2BMDWWcH7DvD0M3CTanxg0mPbj6eoy89RkTsnVQFNGQh1wFua4lGZWRF0LgMKdvoflfCPKGHuuI/0YM/znmSKRs59OtO1dlUvlQj1LWKq8VFDag9s4Bs3Lm1MY2Ek8qCgJoqeCSi4bcQXnU5KVwKan+jm9h6Z1jAY5mB2JwrW0HH0MZe7+RISuvCgRo7SueYkhYE2+mLLgXUOWnOPibM6LQ462IWCSCMcfInovd3xidHpy1dSTYn3MTQXBPHFO0ZetjJWBiBKKw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by VE1PR10MB3854.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:800:164::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.34; Mon, 29 Apr
 2024 14:18:05 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408%6]) with mapi id 15.20.7519.031; Mon, 29 Apr 2024
 14:18:05 +0000
Message-ID: <85a824bc-fbe8-488e-9ea4-5cb100ed5fe5@siemens.com>
Date: Mon, 29 Apr 2024 16:18:03 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [isar-cip-core][PATCH v4 3/3] doc/README.swupdate.md: Update
 steps to test Delta software Update
To: Adithya.Balakumar@toshiba-tsip.com, cip-dev@lists.cip-project.org
CC: quirin.gylstorff@siemens.com, felix.moessbauer@siemens.com,
 Shivanand.Kunijadar@toshiba-tsip.com, Sai.Sathujoda@toshiba-tsip.com,
 dinesh.kumar@toshiba-tsip.com, kazuhiro3.hayashi@toshiba.co.jp
References: <20240425094444.404036-1-Adithya.Balakumar@toshiba-tsip.com>
 <20240425094444.404036-4-Adithya.Balakumar@toshiba-tsip.com>
 <e9c236a6-0d71-4e45-9a95-c5edf8147dff@siemens.com>
 <TYCPR01MB9669AB2FDC68445709AFD32DC41B2@TYCPR01MB9669.jpnprd01.prod.outlook.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Content-Language: en-US
In-Reply-To: <TYCPR01MB9669AB2FDC68445709AFD32DC41B2@TYCPR01MB9669.jpnprd01.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: FR2P281CA0167.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:99::15) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|VE1PR10MB3854:EE_
X-MS-Office365-Filtering-Correlation-Id: c9c7c7f7-d795-4645-804f-08dc68572fe3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|376005|366007|1800799015;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?0iWMeMSk9j05xN0SuX+gTyBkFDnq3k9kUST1VLSnsM3IhAoGiUfxMN6kC4ji?=
 =?us-ascii?Q?OTWTxX1sYdKj/6bpmlkMFQuqmyYNAI8NKRfG4fhQt9cm4LVpj0F0S86z2jgD?=
 =?us-ascii?Q?Guf5sKRDa+y65ERbsFGUUXCLmDIvDCBbTrFYmjeKwUEIOQf3vS8imuR28r0h?=
 =?us-ascii?Q?L8Lff8CUgzjTROpGwTyUdleeLfvK731b4QkdpRWz86q/nzjln6aqpITrgS12?=
 =?us-ascii?Q?LHjDFIjd9lcQQvaNFhTF6+X3ui6JiAyv+tAlCl6VMSe7RzdopCPW5AMNO2Sv?=
 =?us-ascii?Q?aHGSmYGXewfkfsZt8NY2KS6jgvIF2VERvxo72JqVp4HKcfyM06u6LZbmULEV?=
 =?us-ascii?Q?2Ja1SMmcbI9ITshqBBBbSQdrBYC9Hc74PP3XHZn2FxU5eH9jDyre90UK6EWr?=
 =?us-ascii?Q?3FtW4vI7gP9gxuvwQuN90379Elpd1A7GLVPrMs61LHRw2JkJXCrsqdf8MciN?=
 =?us-ascii?Q?qdsJAmb+yLMK47naxwYUnOfbbjcWudJzRbVppTuua7MjcNLtJwIjpuORtsDj?=
 =?us-ascii?Q?9Xl3UARWdqI8C/q4WB7VffJm51sqXZ04iTzwHYwi1un9w1qDu4MZL5j3nBIq?=
 =?us-ascii?Q?RbrgRqx2PM4u+AleR2HlFbGHuqBwst0wfX4l2y3lPDCoxv5t+jhnEuyPrR1a?=
 =?us-ascii?Q?DrLnaf+ShCKr8tu8rCwm3y82TAVOafeaidrbu5g2oXp0O+OxLcVVptxT8laY?=
 =?us-ascii?Q?iIZze1394/tO78BZ8Pea9niblLxIodYDj6uXio+87Q7w9xLQF/bHB20Yjuc0?=
 =?us-ascii?Q?eVpPxRSr1Au1oqSmWZ2rLrjFOpJaZ9aWjkt8JPtoTcgYOiGZStgjorroVrQs?=
 =?us-ascii?Q?ZczaBC3RYdWNpBXDUvrS0Hy6ObW6/nZca/P8qLP0Ov6pnCRyKQXYFiBylVol?=
 =?us-ascii?Q?VWopPk2Yjg2aFR2oAEjPdpV6XpiaH5Hry7pPvr5gNgNH1cONAIdEVQun42oH?=
 =?us-ascii?Q?QhLx7v8K5w7PV7QbWl68kNhojWLHTS3B6Ydwg4RaWZoUeKZj/p8l67T3fytc?=
 =?us-ascii?Q?7lZ9E19dfkd2CUaApahehUR5Nj1Mr5d9yKXCpxMiVc4jkNU8J8mctWLAjTPL?=
 =?us-ascii?Q?6kjPPcYVPpFmZwRfL2vETok923r4Are3zYnwGPt4Px62qCuiY84BXXM9YwTZ?=
 =?us-ascii?Q?dSuCeQoNGz/IoXy7G7viWFZL2SVzEI+q13U6LaJ71i3vH4mHCj2M5hqqxbke?=
 =?us-ascii?Q?+UGIZUaBLfeLZU1z9S7a7qHTw7DfdmeyZg5JnTD/JOE5oogtnqcu568PELly?=
 =?us-ascii?Q?u2kIwVLaN5JNPsdTjk1iMKUPkMzX7SwEexYnsON1YQ=3D=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(376005)(366007)(1800799015);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?btwFM8H118M9IFaqhox9zsyBSUuhhYZNqgWOPyxdK7yLrshQ90GkUA/GDVyP?=
 =?us-ascii?Q?GfhODNos86ZHNC0Ri5kas4+KuwexUUUxixSqOJhhyX8WBY/VlLIF3WP3CHZD?=
 =?us-ascii?Q?zS9Mu24gJESHDz6Ufc2Zv4XKKhEDy83blPDDqtkmLuiWZ9L39n0/FxScYMf3?=
 =?us-ascii?Q?sJVobhNQhIbF+Rj2bAh5jUY7vjaz+IcFaX9ufv4heDjSwaJzGi07+myJFBn/?=
 =?us-ascii?Q?2KscFgqiJAhs7wQseYibHtvq7WvAhNhpfIABEIzsPPiu9enRFqIBiJvDtpDk?=
 =?us-ascii?Q?HwogQ09EobxFl6CK2lZ9NjLXa3cdt4K6PBzsdIgqt+tS8IFmQlcVDeQ0IT2K?=
 =?us-ascii?Q?R9zTxZ3liTsNwC9YvFscnaGtCnIrwHxrxtzT2WOh2LOJpWV+xYEkjO/OaX9l?=
 =?us-ascii?Q?c5gTBmY1IBPhuTOK6rQAfrlU3sVuTkAjk4Y5JNjlS1k4h8kEy+awzmHZK9RC?=
 =?us-ascii?Q?KhUXSUhIF6JbqiJC+9kCxESh4k+T7SOz2QFmnQnmTkVhb9BaD3MRnV9F12MV?=
 =?us-ascii?Q?nYycD4ZJBhNygjKXOXLkIkNBzWWaB0XPufZxUwSz1Sx3NhHJGNzVR/cOxs/n?=
 =?us-ascii?Q?wnKBjYsMACNduevNsjN+YySsDd66kDKD2XcGUI7ndvZ6VG9GzFLvnsZ3aiwf?=
 =?us-ascii?Q?z88dRYKSsOVQg71fEPX8ASjLK4QORmTpzCtR3BWFrf8paoSmcOUEZlt9h6PP?=
 =?us-ascii?Q?h+3C6oZEMdp3/ZVj4ObWGbe6+pmkAUlkB2WFVGYM21OhQUl+TUr+3OLXulp2?=
 =?us-ascii?Q?sEqe8U9JgkfJoaYGQp5wR3oLu/sxBfiSaIYS9ERbPvRvZiFRq83nizJxNR9y?=
 =?us-ascii?Q?74t+70jQP+OP7FrZr/SJbhTQigDYQ7H7AwTCodahpisrLlJmaAkeCdrnxtms?=
 =?us-ascii?Q?sQc/gS7UF3yWFJOMrrkr3WoAfeMxOUqXgmNWWeUxYc7rv51Pz5RSk5WVVhF9?=
 =?us-ascii?Q?lyEcq+3luJdDQxa2uUP8P+x0mV9/WnyTWq1fpPMBbRkJnTvWknO90YYHloqw?=
 =?us-ascii?Q?XwU0Jpc7eRmaAk72QYIp6qInxZ1+3RtNjaQU2/ixXaTI3kXz1x7/akYUI9B7?=
 =?us-ascii?Q?jLcfM+HPG1PptJZgrq+olw4O7cWgiYaMw7uY4CDDXuOQFPOsbtNxgLloEOFV?=
 =?us-ascii?Q?qwgzU9/H1g4goTFlmrOf7XuwOEPCJW1RT55qpeIKjrBAuWediYXecKRwPyGV?=
 =?us-ascii?Q?tpPbTwfI1HcXkDRcgUgYAuDa8nGS3QZJ8SjSRab2ztnQz8pYbNbC8bxuRoXH?=
 =?us-ascii?Q?UBVq5vEBapMFHMKG2+WhQx5Xe1B0zUP4/MXTQbceprtt8eIlVPe6XEKxOdZi?=
 =?us-ascii?Q?QJoBU+zZQ5Pdug3J5W/TidAM9G3I9U30FYEtvKrNrs84PhSWxT36aBVvZysl?=
 =?us-ascii?Q?wVpcck9GFs5GSR4jkz7R281mI0x7mlR1riiZ54dBZVpzFbneTlSs28tZ2Ea8?=
 =?us-ascii?Q?QfuuPx7zgEkwcoebczF8r5JLIE/pAvGCF+wZb+GHSVL6r2/osZ9K3kz2YAEU?=
 =?us-ascii?Q?A9Am9RWvvKI1gp4IO16Lp84S0skaVWdFNLv+2HmbG6cjfMKsQFFH3sn/KqAO?=
 =?us-ascii?Q?zIcMDvwRYDfgZR4hhmawVHVx7D2rziyruXo+bAfFyJai7dNCvJqGv2HgSPDf?=
 =?us-ascii?Q?0w=3D=3D?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c9c7c7f7-d795-4645-804f-08dc68572fe3
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Apr 2024 14:18:05.5531
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rM7IyJYRpUu0Xae5mMIUx+vQZ9jsOx5dHDzcBXsIoRO6+P66f5CTU7zfb+QcVU+WP+8P49Ck6C4qgUlj4I1C7Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VE1PR10MB3854
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 29 Apr 2024 14:18:18 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/15780

On 29.04.24 15:05, Adithya.Balakumar@toshiba-tsip.com wrote:
>=20
>=20
> -----Original Message-----
> From: Jan Kiszka <jan.kiszka@siemens.com>=20
> Sent: Monday, April 29, 2024 6:15 PM
> To: balakumar adithya(=EF=BC=B4=EF=BC=B3=EF=BC=A9=EF=BC=B0 TEUR) <Adithya=
.Balakumar@toshiba-tsip.com>; cip-dev@lists.cip-project.org
> Cc: quirin.gylstorff@siemens.com; felix.moessbauer@siemens.com; kunijadar=
 shivanand(=EF=BC=B4=EF=BC=B3=EF=BC=A9=EF=BC=B0 TMIEC ODG Porting) <Shivana=
nd.Kunijadar@toshiba-tsip.com>; ashrith sai(=EF=BC=B4=EF=BC=B3=EF=BC=A9=EF=
=BC=B0) <Sai.Sathujoda@toshiba-tsip.com>; dinesh kumar(=EF=BC=B4=EF=BC=B3=
=EF=BC=A9=EF=BC=B0 TMIEC ODG Porting) <dinesh.kumar@toshiba-tsip.com>; haya=
shi kazuhiro(=E6=9E=97 =E5=92=8C=E5=AE=8F =EF=BC=A4=EF=BC=AD=EF=BC=A5 =E2=
=97=8B=EF=BC=A4=EF=BC=A9=EF=BC=A7=E2=96=A1=EF=BC=AD=EF=BC=B0=EF=BC=B3=E2=97=
=8B=EF=BC=AD=EF=BC=B0=EF=BC=94) <kazuhiro3.hayashi@toshiba.co.jp>
> Subject: Re: [isar-cip-core][PATCH v4 3/3] doc/README.swupdate.md: Update=
 steps to test Delta software Update
>=20
> On 25.04.24 11:44, Adithya Balakumar wrote:
>> This change includes steps to verify Delta Software Update with=20
>> rdiff_image and delta handler
>>
>> Signed-off-by: Adithya Balakumar <Adithya.Balakumar@toshiba-tsip.com>
>> ---
>>  doc/README.swupdate.md | 59=20
>> ++++++++++++++++++++++++++++++++++++++++++
>>  1 file changed, 59 insertions(+)
>>
>> diff --git a/doc/README.swupdate.md b/doc/README.swupdate.md index=20
>> b7e13f7..d955868 100644
>> --- a/doc/README.swupdate.md
>> +++ b/doc/README.swupdate.md
>> @@ -360,6 +360,65 @@ user variables:
>> =20
>>  ```
>> =20
>> +# Building and testing the CIP Core image for Delta Software Update
>> +
>> +Set up `kas-container` as described in the [top-level README](../README=
.md), and then proceed with the following steps.
>> +
>> +First build an image using the following command:
>> +```
>> +host$ ./kas-container build=20
>> +kas-cip.yml:kas/board/qemu-amd64.yml:kas/opt/ebg-swu.yml:kas/opt/rt.y
>> +ml
>> +```
>> +The above image will be used as the base image to which the update is a=
pplied.
>> +
>> +## Delta Software Update using rdiff_image handler
>> +
>> +Creating an delta update file for rdiff_image handler requires a refere=
nce artifact (against which the delta is computed). In this case, the image=
 built in the previous section can be used as the reference artifact(.squas=
hfs/.verity file). Set the variable `DELTA_UPDATE_TYPE` as `rdiff` and set =
the variable `DELTA_RDIFF_REF_IMAGE` with the name of the reference artifac=
t. The values of `DELTA_UPDATE_TYPE` and `DELTA_RDIFF_REF_IMAGE` can be cha=
nged in the `swupdate.yml` file.
>> +
>=20
> Can't we enable rdiff by default set DELTA_RDIFF_REF_IMAGE for our own de=
mo image? I don't want to hack on the code to try things out, at most selec=
t an option in the kconfig menu.=20
>=20
> [Adithya Balakumar]=20
> Hi Jan,
>=20
> I was considering this approach as suggested by you here. But when rdiff =
is given as a default option and if the necessary artifact was **not** prov=
ided at the expected location, then we would have to fallback to create a c=
omplete update swu file. It could cause a confusion for the user.=20
>=20
> Or maybe handle the above situation by a warning msg that we are falling =
back to creating a complete swu file.
>=20

If we want to enforce the expectations and deliverables, then we need to
provide at least a kas option file to enable this mode. IIRC, we came
from there, and I asked to avoid that :).

So, we are currently generating only one SWU, and that is either a full
or a delta image, depending on the configured mode? Why not generating
both? Not easily expressible in our current classes/recipes?

Jan

--=20
Siemens AG, Technology
Linux Expert Center


