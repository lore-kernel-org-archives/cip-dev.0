Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58A8FEB64DC
	for <webhook@archiver.kernel.org>; Mon, 17 Jul 2023 07:52:45 +0000 (UTC)
Received: from EUR04-HE1-obe.outbound.protection.outlook.com (EUR04-HE1-obe.outbound.protection.outlook.com [40.107.7.71])
 by mx.groups.io with SMTP id smtpd.web10.3395.1689580359857752079
 for <cip-dev@lists.cip-project.org>;
 Mon, 17 Jul 2023 00:52:40 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="body hash did not verify" header.i=@siemens.com header.s=selector2 header.b=Tw60xZpO;
 spf=pass (domain: siemens.com, ip: 40.107.7.71, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DmsCZT9tEPEgTbPUq3a9epHVIi4mppXyPjDDn12hBnr/aye+UX9pyckHo/Le+stmM70RlkDlgANoWtThswNzxcqSmQyTQsi/YRpxMd/lNwp+9bUsePJ05v6r7pX4wH7oHLOeQRvKpH0DsKIUejtefV80nSvnRCZZVlLbNPiKwnKQLuUSh3NYWlpknEi0FRSINC/Ew/73LASZYXhFzRzp8Moeq/spFh9hjf2vtnZuCDXRJfTwhjGzR3j17z9Ov46rDVvBG60o7GLlWuPP0pxtckV9pgbMZ0gJiStnadGhUo3Af7euFigmqyzhhieAGLqdYJO2nWPbWVV03FFDVXjRNQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+U3pXQMvPmMPFP9jhE8hL1iSWg5xvTcCi04cid4YlbE=;
 b=YfCDiFiDn5MYoj5FZhbeMxeqErdBZ7vfjNPwqp5aDRWoxvihkPWaVh/YxHodl2Vo9zsvLkaOjuCdJ8J6uIsfHyp4utxQqx+uYPc5hIke1P9DX+jMFl2WW9LvHEs7zRneKMS2JQka9ausMdbIcklgWyis9QlhLwa5gDG/bQw0wuCwSmaJWdOLglm0CkLabynj+EZJTD0nmNQGkKy2kRgb74ttArCNTHDt40X2v3zKXIglZDPAY6foopmpx/LnYbPOmagLsC0T6peXKpoFJUspixc9LPWOWiJAzso1eqBqzxLOTsnL4ZQqLCPUzv0VuZR7L0RGs6YoSa6r+k248CAGzg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+U3pXQMvPmMPFP9jhE8hL1iSWg5xvTcCi04cid4YlbE=;
 b=Tw60xZpOfUlQiXdCxpaa9znDR6StJxWqAIeBkFHXKsVIQ0L+XBGHNOrK/RyRsFygmgWxyhBncAz/vVEwdLZ8z/hcmQoZqyrTtbT1IptIM5t/gqSsHndx/PsDq2J73VGzvB0aSJAimB5xj4/D1XNSwpbCg+Dd1RRt8luzq2HeDcnk8Q312jodQakjoRHB+1jPeXxunqJkHhLQMZJXu2jlTNpkkpbfw4q3mpf27ZW/pqYNWObZntcBbAbctwV802nC+PgJl4M3oD7M5sjUvUTBvtOVKlP5c8SA2dCEER35QH8C9ict7aZL7NN1+m1R9Fl7kS1cwsxzvLAwOHLwhrOdCA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by GV2PR10MB6090.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:150:aa::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6588.31; Mon, 17 Jul
 2023 07:52:36 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::77d2:3a68:9741:67cf]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::77d2:3a68:9741:67cf%4]) with mapi id 15.20.6588.031; Mon, 17 Jul 2023
 07:52:36 +0000
Message-ID: <7d26071a-0dfe-3dda-63d2-2668f59ece0c@siemens.com>
Date: Mon, 17 Jul 2023 09:52:34 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [isar-cip-core] security.yml: Add additional features to security
 image
Content-Language: en-US
To: Sai.Sathujoda@toshiba-tsip.com, cip-dev@lists.cip-project.org
CC: dinesh.kumar@toshiba-tsip.com, kazuhiro3.hayashi@toshiba.co.jp
References: <20230712113153.1194397-1-Sai.Sathujoda@toshiba-tsip.com>
 <5b400f7b-4039-2fc8-5f84-2fe647ff8a3d@siemens.com>
 <fd3970a0-2375-6838-2d7d-182c6d392826@siemens.com>
 <OSAPR01MB49453BFD645F5F0732DD719FC23BA@OSAPR01MB4945.jpnprd01.prod.outlook.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
In-Reply-To: <OSAPR01MB49453BFD645F5F0732DD719FC23BA@OSAPR01MB4945.jpnprd01.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: FR2P281CA0003.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a::13) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|GV2PR10MB6090:EE_
X-MS-Office365-Filtering-Correlation-Id: 1579f7d4-7f21-4b10-62eb-08db869ac922
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	6/cwQyyGEOLLiuborKk8AFpnIKtAjXT6ojBkeKZ9psQaFB63M9J+T4+NBVZWlzhM22QFRidzPejwMXdH0BdpvnayH4Gv5wmifWqcVpKHG4BxV5szCInTw6T9CeeJAHJ3YjvYw39f3zpPdYvLh5Ncos3oyCDSwxRJpkTJFEvYVyNS1sueYgaDQfNubphCpEFXP2Ih9RhiBJXU0G+8DJsoveoEbjDgxsfSqIKAkB69jls4V4wUe9LcBoTdb/AD2/KmnVhtsssAiDXgKjoK5BBBx7L5SgzO+dWZfmgYlZw89mquK8v+mkLTdV6TxUnKDqS44AkAFD5CG7PYt4Bu7b2Q89gw6g+Wl9dbQGp38XKH0Eo+czzaFDmy05zVmhHrm6CpE48eYrx6wAWyYWHgGEvhFceDrHGfkg7sJQGYLJ+fw9CnKm6JEX/R7Cs5ZjM/HuddxZoXGQR8+swwvH1XavPlvsa+4lZZ8a8vdeM6TZhchyEEBTIC3xHuHvpg/HT1LajzliaeaGWLn5FcE+skdDY2pLVqL2avHGcI4Y1uslkKtfTj2LNGJBuFYVsIuZQxsC0XUlO3GY8pnxX5yqZBcE0RlU6mtd5PcVvquOaWcWryyEtCqHJwbSUmSpyk9Z8HyozIeCscfVHJUoJnlnGgTdJRsg==
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(136003)(376002)(346002)(366004)(396003)(451199021)(6486002)(26005)(6506007)(53546011)(6512007)(36756003)(2616005)(83380400001)(31696002)(86362001)(38100700002)(82960400001)(186003)(8676002)(8936002)(2906002)(41300700001)(478600001)(44832011)(4326008)(5660300002)(316002)(66946007)(66556008)(66476007)(15650500001)(31686004)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?J1BCC0FF7+yObUaU1acIW4IDT9WltiHWjxDXEKyEtOwij9ii9SzzK5brTSbf?=
 =?us-ascii?Q?848M4S4XKokz53l+4Ovr7geqmvS4Sg5DHz4VQcqzvyQeJ7FgAwkq9E4kyJ56?=
 =?us-ascii?Q?d/1dKzVdU/xWTjJPd2N/ImwmMPhu7T+Gur3Bqxu37ybQF7fEKKsLd9hpZE1B?=
 =?us-ascii?Q?vnyA3Vjh5nfCq5w0ht6UjUubztqv1IT31zQrwtVbv2I+TkwmOYIIusS3vlOR?=
 =?us-ascii?Q?Quka3Spys+gasU6qNYqnqo95tG+v+p7VSsZQ9C/PD4gP2OMqPlQEMLqgqqAg?=
 =?us-ascii?Q?l3+HJLtq+RXGXSOrN1mEZ552Fqb5BhY9csfA1CoQz4o2VXHIRoDnfiI6fCkT?=
 =?us-ascii?Q?mc8fmwPxEMouv8Hcnv8hpNio1oVxfaBaDu7hKzEZE1Gd2I7pWJGM3yGSu2iv?=
 =?us-ascii?Q?g2PMxFh3OMRmnjdtIZ4wwymBKoN5V5nb0FqegFyQOJE/4kAohHUpmfigFS7Z?=
 =?us-ascii?Q?pD5VUCovJi67r97vrRIKhvmBaCUohwca6hczH0X4nzOw0A29LTMm3sMUre4D?=
 =?us-ascii?Q?gCMeu0i07DXW7cv4R+DxGPp10R6tiwukAwn7xK+XjzjXwwLKk3uj54g6laUH?=
 =?us-ascii?Q?hbwHXSGSIeKsyKNfZgUeXBooEMMD4y5ky3fd3YQor9InY6Z7dGB3WVZNDSOB?=
 =?us-ascii?Q?LTL9t8XCmsGvtB1CRqv1VW003HwUMl1TADLTIbBLyNhsjJ6NcR+z/9DY3jO4?=
 =?us-ascii?Q?n7AlKI5y++wy711Bz4P4qJuEQvlIunI8nuGqN4G2GdHxF6N9+h+1ZvMS+4xA?=
 =?us-ascii?Q?Xo4HCGw85cRkiDBr/0CnQ/XB4bK3akLvZrgRAXA3rK/ydvKIx8mJPeYjImvf?=
 =?us-ascii?Q?3Eyag6iWEPNHLqEOVhC0QPguxMX108eLVl/KS4qTsHoVkoIQIH6CjCZPCAfr?=
 =?us-ascii?Q?kF3TVWvOSG1HtCiVGHt5LgsXQTJbpQL9cdJyjf6bwnnSK3ZBhwi/EKeSuF8U?=
 =?us-ascii?Q?JyYsYrGTahm/B26MSeOqYQ8j9ndG4zrNVDgccJcgTDSGCZkyI/lPh7AygSwI?=
 =?us-ascii?Q?oxhaYpTJgg6hAbdgdJY0LyWEMW+BOFrqkFVmV00Vtv6AT9YSeSCgh82M+/aH?=
 =?us-ascii?Q?v0iQknYRFoQQmz7Xo0lsosCZ6S112h3g7p9l2JgeOnn11NCaWVT6i7WAHLhx?=
 =?us-ascii?Q?zlKQUm3bcwOQFdBboFD42ld5DkVOOZ7zY+CDb0kxdmx2fXyJZ9AM20IJorVC?=
 =?us-ascii?Q?wrAKA8BmAaUgjhBko59ptQ0WvSNzgAsamFsUAdeL2m6bcOG6STZz5nZZcZ9s?=
 =?us-ascii?Q?u/u+LR+UncFEm/XgKBONwB9X6s0gFGxUM7wRkclX4AmKyhuUKcVOp2oOBZdn?=
 =?us-ascii?Q?OXSCQnEBwHrNP4ry1T2vPAIOMmyMY6KapSQggAgh+F4FEaJNINylqrYWTV6C?=
 =?us-ascii?Q?V/smDD/Q36E5YH3NLxAD4MUQ7OgICd13tKFSDOchTgyHzmpCk9VOyWfkMcWO?=
 =?us-ascii?Q?hKTFj8Q/OlWTTPFoBq7J8KwPHvmjZnV39auasRsqtOLgdIChG5NBE55B6KSG?=
 =?us-ascii?Q?W8A7RFk3w2BjK/uzLbKFBaDDsOioRNyZU+A9aoapAXSrkU6yXyKEKvDq3vCI?=
 =?us-ascii?Q?mkRHtjZ5+PJKSAacwy+Jez4iaA16xTWeRamsV1FeNiusCq5uJCRJrjcpn9tZ?=
 =?us-ascii?Q?gQ=3D=3D?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1579f7d4-7f21-4b10-62eb-08db869ac922
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jul 2023 07:52:36.1395
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: knU2tLWNX4fVlKRK1xCSkJHUpAngos/Dv5mem/aIxFmjEOouaiTyQ5/oUf4XHj9gjzvU0/LXaMz+RL6XZkltIg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV2PR10MB6090
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 17 Jul 2023 07:52:45 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/12364

On 17.07.23 09:37, Sai.Sathujoda@toshiba-tsip.com wrote:
> Hi Jan,
>=20
> So you mean to say that, Kconfig file needs to modified so that the extra=
 features are selected when Security extensions is selected ?
>=20

For example. Or make them invisible.

Jan

> Regards,
> Sai Ashrith (T S I P)
>=20
> -----Original Message-----
> From: Jan Kiszka <jan.kiszka@siemens.com>=20
> Sent: Friday, July 14, 2023 11:40 AM
> To: ashrith sai(=EF=BC=B4=EF=BC=B3=EF=BC=A9=EF=BC=B0) <Sai.Sathujoda@tosh=
iba-tsip.com>; cip-dev@lists.cip-project.org
> Cc: dinesh kumar(=EF=BC=B4=EF=BC=B3=EF=BC=A9=EF=BC=B0 TMIEC ODG Porting) =
<dinesh.kumar@toshiba-tsip.com>; hayashi kazuhiro(=E6=9E=97 =E5=92=8C=E5=AE=
=8F =EF=BC=A4=EF=BC=AD=EF=BC=A5 =E2=97=8B=EF=BC=A4=EF=BC=A9=EF=BC=A7=E2=96=
=A1=EF=BC=AD=EF=BC=B0=EF=BC=B3=E2=97=8B=EF=BC=AD=EF=BC=B0=EF=BC=94) <kazuhi=
ro3.hayashi@toshiba.co.jp>
> Subject: Re: [isar-cip-core] security.yml: Add additional features to sec=
urity image
>=20
> On 13.07.23 19:32, Jan Kiszka wrote:
>> On 12.07.23 13:31, Sai.Sathujoda@toshiba-tsip.com wrote:
>>> From: Sai <Sai.Sathujoda@toshiba-tsip.com>
>>>
>>> From IEC certification perspective, a security image is needed which ha=
s the below features along with security customizations.
>>> 1. Data encryption (CR4.1)
>>> 2. Secure boot (EDR 3.14)
>>> 3. SWupdate (NDR 3.10)
>>>
>>> The config.yaml will not have the extra enabled features as true.=20
>>> Hence they should be passed in the image run command.
>>>
>>> Signed-off-by: Sai <Sai.Sathujoda@toshiba-tsip.com>
>>> ---
>>>  doc/README.security-testing.md | 2 +-
>>>  kas/opt/security.yml           | 3 +++
>>>  2 files changed, 4 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/doc/README.security-testing.md=20
>>> b/doc/README.security-testing.md index c9540be..97000da 100644
>>> --- a/doc/README.security-testing.md
>>> +++ b/doc/README.security-testing.md
>>> @@ -33,7 +33,7 @@ Save & Build
>>>  ```
>>>  # Boot the Linux image
>>>  ```
>>> -host$ ./start-qemu.sh x86
>>> +host$ SECURE_BOOT=3D"true" TPM2_ENCRYPTION=3D"true" ./start-qemu.sh x8=
6
>>>  ```
>>> =20
>>>  # Copy security tests in to the Linux image diff --git=20
>>> a/kas/opt/security.yml b/kas/opt/security.yml index 1f3745b..b21f330=20
>>> 100644
>>> --- a/kas/opt/security.yml
>>> +++ b/kas/opt/security.yml
>>> @@ -10,6 +10,9 @@
>>>  #
>>>  header:
>>>    version: 12
>>> +  includes:
>>> +    - kas/opt/encrypt-partitions.yml
>>> +    - kas/opt/ebg-secure-boot-snakeoil.yml
>>> =20
>>>  target: cip-core-image-security
>>> =20
>>
>> Thanks, still applied for the release.
>>
>=20
> Artifact upload was broken by this. And the should still adjust Kconfig t=
o reflect the implicit selection of security.yml.
>=20
> I'm dropping this for now, it's more complicated, likely too much for thi=
s release.
>=20
> Jan
>=20
> --
> Siemens AG, Technology
> Competence Center Embedded Linux

--=20
Siemens AG, Technology
Competence Center Embedded Linux


