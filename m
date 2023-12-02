Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73BEBC4167B
	for <webhook@archiver.kernel.org>; Sat,  2 Dec 2023 04:19:34 +0000 (UTC)
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (EUR05-DB8-obe.outbound.protection.outlook.com [40.107.20.62])
 by mx.groups.io with SMTP id smtpd.web11.12235.1701490770782023859
 for <cip-dev@lists.cip-project.org>;
 Fri, 01 Dec 2023 20:19:31 -0800
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@siemens.com header.s=selector2 header.b=hbZdjLEz;
 spf=pass (domain: siemens.com, ip: 40.107.20.62, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QGMK3ZqBrjbxQaJ8twKWUoOMa7TJaSS0ZK9CB3dCqOlH0hxqFZsRhbed6m2Q/9LMlNW5FsUriq56aytCNxieTQ1HMPWLaZUANL5FPQOQT0Vpn3FHNbDAMewK2FDZJmJnNZ01EI0FKkn7TZWApEHY2obLUvb9M6aKzBgjgPDeNQQmvytpHhC2XMFV+yVuwbPN9O0n34YhLzjujNBSU3C9dX/V1zY1ZVrmWgyCo5Dn0+Poytjum67CmEffSzAFc7pmgWrbV5qJuoHqnaE5kqzsL8sVwGoPywWClaYpNsRn85X9CJpyMJR7prPn2Gk98JwEYpKe3zYcd2OQNIXtzoz4Bg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rEPK12A3IcFcpUXbjs1q55PQhZwGBVOdNxaz6WVA+Z0=;
 b=lUCWFChUBBM/OsseF2vlPCVQ+GLoiIfZpj0tUQrM/Uw2QWDrqTw77BspK9Hzy2SPFedtkJGYEQCbCHn5Bg7m4D4zNeNBiz/yIbYis5Pxqd+eTESTcA7dgbvuzW/EbC5bACMcD0BwwEZYAI/xOOKP2MTei+ht8fr7S2muLUOagJ/2ba4EsmoZNfCiSH4HxlTMRV8ejkv61FuNMKgw8FtazZgJteqNbfbWZ3GzqzsHfEk8gLQ0HxOltWaPHXSaJTCwnDVpGJ6y8zFBay31po9L51HvFuvPanIdPyVma3iyrirjA52Is2dSC1IRQzeJv4tD9K9b+lWaLB1D04GRv1UHVg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rEPK12A3IcFcpUXbjs1q55PQhZwGBVOdNxaz6WVA+Z0=;
 b=hbZdjLEzxQowrP7TBtH4iK7KuojctpTQucK8kuotgzx1E/zeIAQZj3g0zaDAOE2rC9ES/NVjCK6lA9YkkmDyq8UCAOxOJVxode0qK+U6+sck8mnk07fXe+6ghF/i9yMvKl4hLQjwDjctdthVSKqmDaMnePaKx0YEyZQpZV9iqalLfvSZ7MAtFqJvHCsa13SDGfqMpuwpYTPKGTAG+Y6wfa1Q5FZ0cbMOx91Mu43Cp77izXoRro9d8GV6qdRxqFR6xe4+WRiLNFzKjO/NqN1Mdgl3R0X4dhQ2BCPBdhKLz4UEgsiR2B+Nls44lUXIvuJBg3ga+ekQjB+dfF8BrK7A8w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by PAWPR10MB7746.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:367::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7046.27; Sat, 2 Dec
 2023 04:19:25 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::96c7:d239:1723:8761]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::96c7:d239:1723:8761%5]) with mapi id 15.20.7046.027; Sat, 2 Dec 2023
 04:19:25 +0000
Message-ID: <37f2b1a1-5db6-4c52-9704-9cb19cd8cece@siemens.com>
Date: Sat, 2 Dec 2023 12:19:17 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [cip-dev] [isar-cip-core v1 0/3] Enable CVE check in
 isar-cip-core CI
Content-Language: en-US
To: Sai.Sathujoda@toshiba-tsip.com, cip-dev@lists.cip-project.org
CC: dinesh.kumar@toshiba-tsip.com, kazuhiro3.hayashi@toshiba.co.jp
References: <20231122070121.326276-1-Sai.Sathujoda@toshiba-tsip.com>
 <2eb2c44b-01b8-4f30-aa2e-2d66e889a421@siemens.com>
 <OSAPR01MB49456D20C59D55AE80AA7B2FC281A@OSAPR01MB4945.jpnprd01.prod.outlook.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
In-Reply-To: <OSAPR01MB49456D20C59D55AE80AA7B2FC281A@OSAPR01MB4945.jpnprd01.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: AM0PR08CA0020.eurprd08.prod.outlook.com
 (2603:10a6:208:d2::33) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|PAWPR10MB7746:EE_
X-MS-Office365-Filtering-Correlation-Id: d1601c9e-0a90-4c75-a947-08dbf2edddc6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	0sNI35QKBjr16c94ENFDafwnk1/QeTkhkX/JX/FtsC+GoXJ8tBIi0yIui/U3AOhliEvoj8+A/C1jZoYyhCeVCFtZ8KJmCsSuA2BA1rfP9Rh/2jHJFoCnvp2d8jdV6piLvJxDolRN6scSDaw8DhSZO9CbUi9iyaprtNpdYpyZzDnBc8VNYcyQRdHo10mm+HilSwaK2DALo3rPvpjLz/ogsuvgp4DjqSJ+wjq3vVgF0/JbI03w7WDxotGpZ//cJIXmbgIvYTOq3gxq1FXI+YgR55ADln3W/KyxKRDJIplporCGt38yTEtV3Qj0bZTUHCcHhnHo/w2dUsz3orfie7HgiGovP6zw9zuIkXxns2nsesLx1ARCQaasdOb+pJ0aJ+mwefkYeFP/QR9cQ/U5PJQDzfD3H93eW/DE6TuEQ9g/udSD18HuZnLwNr1/+jqJZOp2JUPcbkGQPvqwvBcMhEXcUrtkAIids0OOxKMBkb07etveRR5yioCzG24Z8AFVw74AtLXTr+kDhG5s0gK1vgg5ZuaukNTEsXTKcu9mfRgKo+7wDTw+sov0jEliJpTgK284kqjas6yYZgOR5DegxttiyrechwIBfl1519x7v6Gyt9UePZfoO2E0nLl0Mmm5tVYIrdy2JBgocYZzJbP80PN9Wg==
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(136003)(39860400002)(346002)(396003)(376002)(366004)(230922051799003)(186009)(64100799003)(451199024)(1800799012)(82960400001)(86362001)(31696002)(38100700002)(36756003)(478600001)(6666004)(316002)(66476007)(66946007)(66556008)(26005)(2616005)(6512007)(6506007)(53546011)(41300700001)(5660300002)(44832011)(6486002)(4326008)(8936002)(8676002)(31686004)(2906002)(83380400001)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?30VuC0FGKd79GcJtBhcnNKtDWI81wDQkTvQzbSXPFj9RSRsmTUygSJNnwMr9?=
 =?us-ascii?Q?VfOYzUXYVyesSVNsxf8eWEPfjO13x6vt+8PLVHdnHFm3oTTcwjya0PxLIbvD?=
 =?us-ascii?Q?MmAYv+ME/tH/mh3cg4sXUyPrJJK4dQWKYnKwD8xdrAsY1MJaAUDlyHFQAlkC?=
 =?us-ascii?Q?4veu+a7h8JX4mH8YU29pgyX2YkCeD6YcbX3Czgq1rF/tUD6VivXUJVYFF4wS?=
 =?us-ascii?Q?GIudc2jFtr/38qGYmGomzYFxNPTNLVdJhY4CiqAAimyG2rSUg8hHdTnKhjND?=
 =?us-ascii?Q?j25N2iJ6L1F6u67IPf9vdYu6ZiYwgothWWCXmMb+cOHab3vO/UoQ0+1pM4Dz?=
 =?us-ascii?Q?IshMO5wuCICKpNLzOumCt0/jsqlcneKG+WyZH1iQYkEsoYL/dd/oPax2BdVI?=
 =?us-ascii?Q?8gpcdrcsoC8LWpvh5TgzNNw2FnnjgjLyv5KuH2XUmdmjYea8LZj9CdRfNMdm?=
 =?us-ascii?Q?UM1eANRFWpyBVx5eqmgEgpqeMDeQ20GG2JBDr4qp/dVv0XTrXK6nk+Ika/J7?=
 =?us-ascii?Q?3IKTZrvHck3ZvEw6kHS1oMbqdwiySFuUELv4XQMZ7AzUUzsDf+g5DJd5XtK9?=
 =?us-ascii?Q?GLiwvSRvmWce8QuzWN9Z5D+7dKVl0f97fL2GHL0cTWPRqRTFhNkMIjt/B+Im?=
 =?us-ascii?Q?An/fC1Z7rsfuHk9mu+RnrUenDWb1WejbithrIc/8UyA9iuTP2m8YpxJqd+9q?=
 =?us-ascii?Q?TI9/kP9ofRALpIB130+8MsrRANoJ3S5RnXyWnFo6t5zMORxdJx7QSJXxvQDg?=
 =?us-ascii?Q?GUaFFIYE1JKZfgjVx3ikbb0m1NPY21j5qTnB+YlTpOWhSQhrPSbKKgIvbiU5?=
 =?us-ascii?Q?gk313CnP4RX5WNExuaDSnDBkC720UKLS6YEZXNlxoBUKDJISacdS0Cd73XCi?=
 =?us-ascii?Q?lUpOZL/3JPnwPzd1lClpUAxI97RIq35bm2Eglq8/lo/t/ifas3Vl/crui3zr?=
 =?us-ascii?Q?KjdT/33smYblap2r/fT174E+U4CExZoqI8kD1N4jfKUt6J0fG7nYy2nZNXTV?=
 =?us-ascii?Q?fzv//oaLwyKLPSodBbdioKRWFRxZc47wlrdPa9ejME+m2THJM7IZqZjGt2g1?=
 =?us-ascii?Q?CY8NsEMAUWjsubJR8FfAptxjo8kyQi/ErxtuUZc9irXGfKxK5DeV1jz2Z2yo?=
 =?us-ascii?Q?eYziUCdt3ckLXiGuyV5pMbA2WWhoLJS9ndAHArvABzJn751ls/9HRqYgwHm0?=
 =?us-ascii?Q?6xWtsLf9LKaPNoHys+8EegQYqoDS6cxaBrC9IR2FJyH32jSyPwBY04+HE0MI?=
 =?us-ascii?Q?3S2homDz/DK+pgcV5h7zFv4UXZ0Y5p06/XcTedEB51sL/5OqsMThasfpvXg+?=
 =?us-ascii?Q?xPruPKfuW6aZwsbOUWq95ZMhv5QIs5/U2Cd1zFIz/MzfcmJUjVS0gSujKz1q?=
 =?us-ascii?Q?4jA4QV1pNtEj/YzwnsHk/E+msuV/3zD+nZLkJWnVUM+D3wb04szSRiy8bp65?=
 =?us-ascii?Q?d+DRaFN2qWBqy1gOIrdjuEaVna5zeSOX/G6tPaTySH2rUFhztwAhHSizdHH5?=
 =?us-ascii?Q?LUNahJR18OYgEzii4HLAsGt6pEdkhBYWogo/R3bp4P3RfQzK399wkTAbqvHP?=
 =?us-ascii?Q?hjKJrS/6S3yftpa4p0/2MuMJbIQ5SDQeBzEiTSbEdNI2V/hhs+ichizZn48C?=
 =?us-ascii?Q?Gg=3D=3D?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d1601c9e-0a90-4c75-a947-08dbf2edddc6
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Dec 2023 04:19:24.6666
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nwA3XSwujYuugDg5Z/BfUQxD3f7QtgnfHnIfkUpF6HUMYUstV1f4hm8vp/1CVZsC83+4o0dwU5w3Plb0JCx+sA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAWPR10MB7746
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Sat, 02 Dec 2023 04:19:34 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/13775

Hi Sai Ashrith-san,

On 01.12.23 19:18, Sai.Sathujoda@toshiba-tsip.com wrote:
> Hi Jan,
>=20
> Sorry for the delayed response.
>=20
> The idea behind this series of patches is to maintain a latest copy of cv=
e-reports for the deployed targets in an s3 location throughout the develop=
ment cycle. Hence we are not focused on getting cve-reports for a particula=
r snapshot. It is unknown when a new package will be added or existing ones=
 will be removed during the development phase, so we are just generating an=
d maintaining a copy of cve-reports for random snapshots on a weekly schedu=
le.
>=20

What is a development cycle in this context?

And who would use these reports, and how would that usage look like?

> Please confirm if you are convinced with my explanation. If you are OK wi=
th it, I will re-order the patches based on previous review comments and se=
nd it for review.

Sorry, I'm not yet getting the idea, but that may be my fault. I'd like
to understand how the reports can help to make sure we are including
them optimally - and can explain their usage to others as well.

Best regards,
Jan

>=20
> Thanks and Regards,
> Sai Ashrith =20
>=20
> -----Original Message-----
> From: cip-dev@lists.cip-project.org <cip-dev@lists.cip-project.org> On Be=
half Of Jan Kiszka via lists.cip-project.org
> Sent: Friday, November 24, 2023 12:46 PM
> To: ashrith sai(=EF=BC=B4=EF=BC=B3=EF=BC=A9=EF=BC=B0) <Sai.Sathujoda@tosh=
iba-tsip.com>; cip-dev@lists.cip-project.org
> Cc: dinesh kumar(=EF=BC=B4=EF=BC=B3=EF=BC=A9=EF=BC=B0 TMIEC ODG Porting) =
<dinesh.kumar@toshiba-tsip.com>; hayashi kazuhiro(=E6=9E=97 =E5=92=8C=E5=AE=
=8F =EF=BC=A4=EF=BC=AD=EF=BC=A5 =E2=97=8B=EF=BC=A4=EF=BC=A9=EF=BC=A7=E2=96=
=A1=EF=BC=AD=EF=BC=B0=EF=BC=B3=E2=97=8B=EF=BC=AD=EF=BC=B0=EF=BC=94) <kazuhi=
ro3.hayashi@toshiba.co.jp>
> Subject: Re: [cip-dev] [isar-cip-core v1 0/3] Enable CVE check in isar-ci=
p-core CI
>=20
> On 22.11.23 15:01, Sai.Sathujoda@toshiba-tsip.com wrote:
>> From: Sai Sathujoda <Sai.Sathujoda@toshiba-tsip.com>
>>
>> This series of patches enables CVE check in isar-cip-core CI by=20
>> extracting the latest dpkg-status files of deployed targets in aws s3=20
>> bucket. A weekly scheduled pipeline runs a cve-checks job which=20
>> generates CVE reports of respective targets by using the cve_checker.py =
script in debian-cve-checker repository [1].
>>
>=20
> I understand the scripts and that they can be useful at the point where y=
ou are actually instantiating an image. However, I'm not yet sure I'm getti=
ng the idea behind doing that test for more or less random snapshot every w=
eekend. Can you elaborate on that?
>=20
> BTW, patch ordering is then wrong because patch 1 uses scripts that are o=
nly introduced by later patches.
>=20
> Thanks,
> Jan
>=20
> --
> Siemens AG, Technology
> Linux Expert Center
>=20

--=20
Siemens AG, Technology
Linux Expert Center


