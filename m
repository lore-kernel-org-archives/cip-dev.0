Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7E61CAC599
	for <webhook@archiver.kernel.org>; Tue, 16 Sep 2025 15:30:06 +0000 (UTC)
Received: from AS8PR04CU009.outbound.protection.outlook.com (AS8PR04CU009.outbound.protection.outlook.com [52.101.70.22])
 by mx.groups.io with SMTP id smtpd.web10.1534.1758036596717069286
 for <cip-dev@lists.cip-project.org>;
 Tue, 16 Sep 2025 08:29:57 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@siemens.com header.s=selector2 header.b=siIPWpA6;
 spf=pass (domain: siemens.com, ip: 52.101.70.22, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Y8XgXbROmJjIJU9Wg1NVKeEv1vp+qP0FuQwt2+fNH+UFFB0UWLx6dEAudAWumjFk/D9t1aIP03NvI4s4azy3qK4sOGIndvoYGjxIfxRt/N1WDGLBddlZJvu6FgBHpPrUbsDEeGD15YO1NG4h1H0DCordT/fp/OrchtWhwHqmbB2dHrgra4oBiSkq51f4y3VgEQq04oOxXl740i12IE5OTSh4Uu9CU24hMS1tzS5mjt0wD2wG/axt9BYfB8NxB/AZtAU+wUKiCG0JM76x2/jcfwUDXD7cHxMgNsJJ832D3R2RpVduUFIeHeLA2GrfOblBuhZuOQv5zARwdmawXFGTrg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=G8kEfJ+TdVsschaJGFwFg2lAEYQ4VJMjYw/HuMEPP4I=;
 b=kXRfvEhrl6s4jq5hco8HV4a2O1s49ehJmZ+Rr2VxwqxjCmVgPJt/XxBD7ZS+0vffIqTx2r8CF793yvVWevRJnAlE1PCtQC/853dlxCMLJD/Ha2kNa8Fs8sls8JWtRgNfMQHkUeANAYMp3b2qsyX2DgUGAm4NLDrSEZuo9c2/Nu1VcOT0bmwpGYN5Wp7c1d1lWKAvQrB/d7tufjH5gpxTGEmg9mxskrOkxH0PEsNQgqX6yqegcBoUyXAUDwBmGHwdC145tJqR/Zmj09EfQlWXCCp2I/N8LN8K402Tve4nF4J/zKw5GxxBwk10CZzRGHGA/LXy50Jb9HFWFvNqG3IK4g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G8kEfJ+TdVsschaJGFwFg2lAEYQ4VJMjYw/HuMEPP4I=;
 b=siIPWpA6UngI6WBJiQHDgdW3IJfyrW02W/AKOt784F1biy/cmLUQfz5b6oya6z7FzNYkJv57EKhGN7+G19efeorszRo/2qIbLUqntBFJmEv2smkHle4GfWg+FgeLI7o2cBY8KAZoXTZJx1dGv5T2S3TNStTfjexFQctXLBd+FK7Z9My/ln3g7PBRc5HdDbdmuTUnmcCzOgkDe0d9GdE4QdtLJ0ZRWnt05XABdOpbiTW/w4oyBE7VUU+YGKuWiHAMOlDjbAOnkHU+LnLzwxuzIJCAHTI8NDP7VhAhLaEflkhHtO36NHQ1JdRprL/TxhUcONAoPr8VGkujt2yWxBsgiQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from GV2PR10MB6186.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:150:76::15)
 by DB5PR10MB7668.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:488::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9115.21; Tue, 16 Sep
 2025 15:29:52 +0000
Received: from GV2PR10MB6186.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::7fc:74bb:a781:a286]) by GV2PR10MB6186.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::7fc:74bb:a781:a286%6]) with mapi id 15.20.9115.018; Tue, 16 Sep 2025
 15:29:52 +0000
Message-ID: <629a5db3-2e22-4d47-9292-267729ebaed0@siemens.com>
Date: Tue, 16 Sep 2025 17:29:48 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [cip-dev][isar-cip-core][PATCH] erofs: Set UUID and
 SOURCE_DATE_EPOCH with empty exclude dir
To: Quirin Gylstorff <quirin.gylstorff@siemens.com>,
 cip-dev@lists.cip-project.org
References: <20250916120952.1771209-1-Quirin.Gylstorff@siemens.com>
 <cd0fa7c6-dcf7-4caf-af60-2931ff4acb4b@siemens.com>
 <df99cce1-ac33-4294-8930-5012f24077b3@siemens.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <df99cce1-ac33-4294-8930-5012f24077b3@siemens.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: CH2PR18CA0003.namprd18.prod.outlook.com
 (2603:10b6:610:4f::13) To GV2PR10MB6186.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:150:76::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR10MB6186:EE_|DB5PR10MB7668:EE_
X-MS-Office365-Filtering-Correlation-Id: 1553694f-aa45-4f4d-39fa-08ddf535e177
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?Y49y+2mK8oQ8Py5nUy8R1TNKuojo7WcI2f6fBH+wvekvklOuGRSgHsKGIKYv?=
 =?us-ascii?Q?8hNS+BzkGQZFT/dWv23v9ON+jWBZQFAb0kL1Kyj+OHUhqbEV12tKKtlgklZV?=
 =?us-ascii?Q?X8KxoB1J9bbGL+8yWazM9AMs6BsbVgPhmrh+puyCKtrGCfw2g+lDPsHnR+B9?=
 =?us-ascii?Q?+PrhmadQ8lVVeU+6JMhB74r0++CIhjI8y1SQc8yhz6SyFmgwPQoy7v2p0ron?=
 =?us-ascii?Q?BGJQbC4SIP1rmRx1AW7qht6sS+FuiHO63lKF3xA/pS6ytiHsCGquovN8KLFl?=
 =?us-ascii?Q?X2fnHoEJE34z/QDfdYidTmddxe/qPasnN+tpQ7O6Ivgv8tMXkNxwyKbMq6/F?=
 =?us-ascii?Q?f6Wjeiz2qMFdnDuUDSpvleGb5kJ1Q6VlW0PIXHupWVW4IdWlH6DwoF/O9Z4I?=
 =?us-ascii?Q?oANJ2fyg7TDhWo0lWjvMyhfg+DNfswYWANhePnFvV8Vg7Q/+QaMSf3NTeKRB?=
 =?us-ascii?Q?ftPBYJx/OTX4b2A+lsQ+kawX2iXOjTxgZhU1ikinYxyN5SsQtA6EouBAX2i6?=
 =?us-ascii?Q?kP5dK9QDeXd8BG7eRq3t2OAKrrVGqsTUiZDhWogx+/gG2jnjl06Mf4la0yp2?=
 =?us-ascii?Q?4SYeq4xFlvLmoOk8UtZpQpt2N7RPSBu/vzMWDUcIevNe302z13AeUXC6D0F2?=
 =?us-ascii?Q?KQof2nY+77lTDwY2ePN96BakfbP19SnrOehOyW/82v4eLjePSnZbby+Mr+6S?=
 =?us-ascii?Q?Dwe7XK0b44445Z2KBXwCdBKrAM4CHjKQVagm0nh2UhTGVHSy714SVWisSR4M?=
 =?us-ascii?Q?UpEXeLQreRX20p4XpmWku4pW2uWvQ2oBscx4WiEbFS5tqr1RTxj6HLMUK7Cp?=
 =?us-ascii?Q?hYZMeK5myQjKwSwDfhVZsEoZ9/k6e4A0qhMzYJ6eN9+IgGAe+DmzXHgUZIxH?=
 =?us-ascii?Q?7LPEJG5Y5NZyUby9vzMdE3Nn0mk0beEFkDUwiTZd3HQLcqaP3Ip+YS1tfi4a?=
 =?us-ascii?Q?R1BKNQlStpm9WVjAita6iULWY9EJyKaYGuWhZuTUnMyqdBEx2mfBWltp74tS?=
 =?us-ascii?Q?fA13cNaGrliGfyQFvrYJaxZ1H2PGznHU7VtfdFzWQV/s5qUtjV3v8MV2yryL?=
 =?us-ascii?Q?6Wp+r5oeHUZd0BUQ8CzrqtvZgjDMvf+BknnCAG83HXrmOJqwQOiOeHuGpBJr?=
 =?us-ascii?Q?ZMahNH6JNCxlH3NueAHB7bITuRGZO/L15iTkiY6dY0SLXXBn32ltWM9Tdys2?=
 =?us-ascii?Q?tHiigkf+uBCLs5ScksZCIo5/qiO3VccAbOBINl/ePrsfZWHvE9bba55PdjWO?=
 =?us-ascii?Q?glyIfH6DFdD67kEUDpCsuoInHATtFn7z5yRZgvOpqLe5bxtv6C1wzFkLebsQ?=
 =?us-ascii?Q?xViBqnaOHLygahLISxPfYvmoylaHbsRq3Vk63n27fz8BDPU9Pr3OEURA7Dn/?=
 =?us-ascii?Q?ECQs5U13JW23x5XWUSSejkvpTwsoeAaNicLBOItqdzE0nUdhAOK3UlNxZLmg?=
 =?us-ascii?Q?BMA+GaTdpTg=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV2PR10MB6186.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?Fvc3vf96xWGiqZMZBOnHYLBOaUEv2V6ShsUBcB1VOTib+1gPKIv1MLtxivXm?=
 =?us-ascii?Q?hjKBkJVt92zT+Zl0N2fqVJUiE+bjFIN0WnOAGPo41dWGKrlVyD+//YJPoy9z?=
 =?us-ascii?Q?Ma+Z/EdI5ASXYM0DEo2t6NuHpEAy+275LxP1mBo+GxuFMqNRIDo5TtvVG8di?=
 =?us-ascii?Q?iTLe8huicRhuQgyDCizHDfYcQCsW0kvXLVngwB1PAPGrIEqLkUcIETYWuwtt?=
 =?us-ascii?Q?DK1eiCRTzP+UeGOem71uY26sagWx3JNQmYe+0ktsPei8fL33ZsSWhlB2Txat?=
 =?us-ascii?Q?139c4jc/QOPEFYRbe0jRQX31ba0H0Wc5ZGadIL4Guv3ZOTHRzJ1wcnjv7evo?=
 =?us-ascii?Q?hc0At2zrosQ4j2tKmX3Yg4n9l3Pmy6uXNgK2CfJtw89RXnJ5IyHxRZ0luw/K?=
 =?us-ascii?Q?shfxEmgbKSzd2tG+ShUCjOQw1dXR+3Y/AxLgyx6Ad22ZJ2NUnswnxmXDswRp?=
 =?us-ascii?Q?hiW+6ewoS0XaZPWMCOpQ2mIwzjp74AD/Hr8qXwAPSHpdcraCNTx8BPerjGXy?=
 =?us-ascii?Q?19apx1/j2BQKbFO03aEFZ1/WZmJlAcmot8e2VML69crLSP/66C5AX02hGGTL?=
 =?us-ascii?Q?vunpQWueIU6t8ynLqF0P2Gy9iY1RigRdxcilV1c1j7+gssQISuw1VqesI8VL?=
 =?us-ascii?Q?zNyiK+4soYIhnh9MjHnG0C9y0l24pylp1T8Ldp5qhom1GkPtIwH/YDIKRts0?=
 =?us-ascii?Q?upcmID+su/iGkL/4uYaSuwjtpbEBppoZ/TrFyInoUaQW8SxrjZ5NcPmhBYTf?=
 =?us-ascii?Q?H3PZCeogIsdDaG/7pszfVAAYfNY/7+OZFHLf8Gdv6MtYYrIEEFHeAHG4PSKZ?=
 =?us-ascii?Q?kM/BWHseCFS84J9BXqeqgOPvpb53/mHxkkJL71Ea6HktqBopMePBzRLTbCIy?=
 =?us-ascii?Q?uw3zakgc4GVVTn0h/z7zIjuusdU/4g88tuHBmStTZd6hTB21SGvE+lMU3RSJ?=
 =?us-ascii?Q?HBN8+eQ2BKAlb7rq6nI3ycwK5AxdOXBHqWDe3Eet4qyPip+j9JhIJlIH/fNd?=
 =?us-ascii?Q?9UzY2qwEQ+DmimMl9y24uKFmSO9gX0pv68eoZEBPb0/n+mhdNCFfB01s5euj?=
 =?us-ascii?Q?BTeMO6tgVS4FxVcke/XWMZmHsCkCCo8fgNSC7V/ix9BVrfbOb/sv4IhRYneU?=
 =?us-ascii?Q?l+elpYbljwPA/M2f3CJZDYQ1IW7K8yRmpXNA0yYJjnDojThMlwl3O5pCDHBU?=
 =?us-ascii?Q?QufXHP0135gIjtQwLcx6TknWCx3Rt/nDKeOxVRlsG7YFNXNC3wx6JAEUzILS?=
 =?us-ascii?Q?SOw4ykCoibMlt/0sNd8ZO6hOoIEsR84cr39qw6+Erf9XtcZ01h8JFHcntwun?=
 =?us-ascii?Q?KbT0neF1AzzPZq/Dynrr8uwYJzcP3y1sLcCuW/hFZhs7L1vVg4CsIZGZVddP?=
 =?us-ascii?Q?yHxw9dbmgx0isaCbiQjQfpbfjr3eGPK/dvGrIjagDS++3evgI6/m3PvyruRz?=
 =?us-ascii?Q?udlJKNqUU3t6BiBj/9fnTjFNeXSp31mwTVDRO+aoNoBWSjeq+nzHR5bf4nI2?=
 =?us-ascii?Q?/rN1W652AXJb/N62MW61+SQCc7I9HhiVk4u3/QyyptjruZNRJLBzu0F0mMbJ?=
 =?us-ascii?Q?tgqu5ckl8CarULtI8DMf66qiL0k8aEsbhidVYGWWpWjn45bsCyEObDfnJkV3?=
 =?us-ascii?Q?tQ=3D=3D?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1553694f-aa45-4f4d-39fa-08ddf535e177
X-MS-Exchange-CrossTenant-AuthSource: GV2PR10MB6186.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Sep 2025 15:29:52.3937
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NEHFDZWKfXoWxqr9B4lEv/CSMgxxyxgNi4oO5xU84kSNFU6yjwdeOma8ey9n8suxtuZWeGTFO0b2ILbdid+B4w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB5PR10MB7668
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 16 Sep 2025 15:30:06 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/20063

On 16.09.25 17:22, Quirin Gylstorff wrote:
>=20
>=20
> On 9/16/25 17:11, Jan Kiszka wrote:
>> On 16.09.25 14:09, Quirin Gylstorff wrote:
>>> From: Quirin Gylstorff <quirin.gylstorff@siemens.com>
>>>
>>> if EROFS_EXCLUDE_DIR is empty then SOURCE_DATE and UUID are not
>>> set. These variables should not be depend on EROFS_EXCLUDE_DIR
>>> as the are necessary for reproducible erofs builds.
>>>
>>
>> Good catch!
>>
>>> Signed-off-by: Quirin Gylstorff <quirin.gylstorff@siemens.com>
>>> ---
>>> =C2=A0 classes/erofs.bbclass | 15 +++++++--------
>>> =C2=A0 1 file changed, 7 insertions(+), 8 deletions(-)
>>>
>>> diff --git a/classes/erofs.bbclass b/classes/erofs.bbclass
>>> index 2743bd1..debf097 100644
>>> --- a/classes/erofs.bbclass
>>> +++ b/classes/erofs.bbclass
>>> @@ -17,21 +17,20 @@ EROFS_CREATION_ARGS ?=3D "-z lz4hc,12"
>>> =C2=A0 =C2=A0 python __anonymous() {
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 exclude_directories =3D d.getVar('EROFS_=
EXCLUDE_DIRS').split()
>>> -=C2=A0=C2=A0=C2=A0 if len(exclude_directories) =3D=3D 0:
>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 args =3D ""
>>> -=C2=A0=C2=A0=C2=A0 # Use regex to exclude only content of the director=
y.
>>> -=C2=A0=C2=A0=C2=A0 # This allows to use the directory as a mount point=
.
>>> -=C2=A0=C2=A0=C2=A0 for dir in exclude_directories:
>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 args +=3D " --exclude-regex=
 '^{dir}/.*' ".format(dir=3Ddir)
>>> -=C2=A0=C2=A0=C2=A0 d.appendVar('EROFS_CREATION_ARGS', args)
>>> +=C2=A0=C2=A0=C2=A0 if len(exclude_directories) > 0:
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 # Use regex to exclude only=
 content of the directory.
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 # This allows to use the di=
rectory as a mount point.
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 for dir in exclude_director=
ies:
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 arg=
s +=3D " --exclude-regex '^{dir}/.*' ".format(dir=3Ddir)
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 d.appendVar('EROFS_CREATION=
_ARGS', args)
>>> =C2=A0 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 import uuid
>>> =C2=A0 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 sde_time =3D int(d.getVar('SOURCE=
_DATE_EPOCH'))
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 erofs_uuid =3D uuid.UUID(int=3Dsde_time)
>>> =C2=A0 -=C2=A0=C2=A0=C2=A0 args =3D "-U " + str(erofs_uuid)
>>> +=C2=A0=C2=A0=C2=A0 args =3D " -U " + str(erofs_uuid)
>>
>> Hmm, I think you wanted to write "+=3D" here, and that is also why you
>> added the space, right?
> +=3D in my testing doesn't add a space. The parser should resolve this bu=
t
> in my testing this lead to something like this
> EROFS_EXCLUDED_DIRS=3D"boot"
> `boot-U`
> so the space makes it in debugging cases more clear. But you are right
> we could simplify it by using d.appendVar(..) add the end and not two
> times.

Oh, now I see how you are (re-)using "args" - confusing, though correct.
And, yes, only calling appendVar once at the end would be clearer then.

Jan

--=20
Siemens AG, Foundational Technologies
Linux Expert Center

