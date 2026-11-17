Received: from OSPPR02CU001.outbound.protection.outlook.com (OSPPR02CU001.outbound.protection.outlook.com [40.107.159.37])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.12363.1794897011074946604
 for <cip-dev@lists.cip-project.org>;
 Mon, 16 Nov 2026 22:30:11 -0800
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@siemens.com header.s=selector2 header.b=Vz+xN3pg;
 spf=pass (domain: siemens.com, ip: 40.107.159.37, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NDBW45RKo4HzjTPMmZQVIobXq/G6exyvQBhN7A34b2NzKX0LVq75w2fHNJnTkuMCJ4Z5ik9lMIH+VdVphXHDKf8Rm6V6gn+3rE1XmRUgU6bW4J4V2IjiD1Hg6xsRS2MzKiPNKiEMmrGI1A2T35g3Bm0QSnI/A+SPFmWOJ5nPauP02xwQNtI0wAfdBCD6kQ+lZHj8dhaCZswehKl+hM6WUdTIgaN16QS54OWDwrxQQmvrUaXg/8ka90h36IP2vKVvO1ml7xF960csCnghHgVEtFZH+YOqqZxfMT7/c0hlQbo4OBU/BByeVnSiLilSj5wIqh0Dg7jodaH8TT823YjQzg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OnwbhHbDOuVHAoe9SNMkMdu7aJTnteIaYzCfl41/+u8=;
 b=SpIiU9DKRaLHjG/FWWfuQbrGiNYPZdojkGZZNPJLztanQLKHwxCS5/lQksv7Cbb8AVHBZkfZhFuYxaWUUcWQ6ow5p9KSG9m3LcMiK4zcF/LHSaeKM59B8FcEdq8CL/m+TFwYTh/rfKk9tdZlRrG0kRD4FjOw+it0rbbbLOzQPOkmfvBocXVZc171Du3kf8836LHIiHwetEzalLeYBT8gzZdRM+vO//oxD0JEzPj6q4b41tWRWBqwk1uflx3TsMryqi6viG8wAixqjVun0OU6Ew80f7RJ+qHdTAxgQlAltEvLfD98FPflm8dAFXoJRlAO33cK4XlZLXh5Lv6nRNTJ6A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OnwbhHbDOuVHAoe9SNMkMdu7aJTnteIaYzCfl41/+u8=;
 b=Vz+xN3pgpwh/pXSPfLa/m2Zy4Frvq+IUoTIHH7o2a1uY+4J+B4ps49bkeLHyBzjPDw08u5AORwHTjSAbNLwdzZXmU7l97XJdfllBMu8GIZGqjjuedmSUikq8iaZdQehz7tqgngzQgL91Thdtiw+bErbLSukg/LtHkPmInluRLNBMX15rRSYgeXTTC1CQkU/J4OnOFXt3RM/nh4LLotnrgpsA7fAxWAiSqSe3p/ozfFnjSly2IHfkDKXgstpRM8P5qeptT6SCSjw+Uk6An7ilOWwbMASAkCQOGaPmiHimsu3ac61gFpds3/EpGHQtx2fdaqMBPVwo29YsrZ3cuUTTgA==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AMCPR10MB992291.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:785::10) by GV2PR10MB6429.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:150:b2::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.8; Tue, 17 Nov
 2026 06:30:06 +0000
Received: from AMCPR10MB992291.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::fbce:789a:27cf:d1e]) by AMCPR10MB992291.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::fbce:789a:27cf:d1e%5]) with mapi id 15.21.0639.006; Tue, 17 Nov 2026
 06:30:06 +0000
Message-ID: <f0c6b12d-8d4d-4083-a9c3-a59dc4c88a37@siemens.com>
Date: Tue, 17 Nov 2026 07:30:05 +0100
User-Agent: Mozilla Thunderbird
From: Jan Kiszka <jan.kiszka@siemens.com>
Subject: [6.12.y-cip][PATCH v3] Add SECURITY.md for the CIP kernel
Content-Language: en-US
To: Ulrich Hecht <uli@fpond.eu>, Pavel Machek <pavel@nabladev.com>,
 Nobuhiro Iwamatsu <nobuhiro.iwamatsu.x90@mail.toshiba>,
 cip-dev <cip-dev@lists.cip-project.org>
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: FR3P281CA0178.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a0::19) To AMCPR10MB992291.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:785::10)
Return-Path: jan.kiszka@siemens.com
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AMCPR10MB992291:EE_|GV2PR10MB6429:EE_
X-MS-Office365-Filtering-Correlation-Id: c77dc152-f12d-40ac-ccf6-08df44743864
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|23010399003|376014|6133799003|18002099003|261009223027099003|55112099003|3023799007|56012099006|261022105027099003|261102123227099003|11063799006|261021121427099003|261026121527099003|261022113327099003|261022075727099003|261028144727099003|261026140227099003|10067099003;
X-Microsoft-Antispam-Message-Info: /nPHJJ6nu8QB3RezWNlgkZqFpqRb9nZOQB4PGMT+4axzM4q+CwJ9LjXDEWZYyjZGP3jKtAoIfZAcX+buZZc9yOUwvslFqkRC3zXFQXJRsvPKBIGzd8kw8AtSy4yhr8rsl5vKocIKF7bpRqx9RaCQ6n4o6ZymRHHQFTRefTPmxceKB8U9jqPaKP332/EQ0CHQ12Kv36oZuFxYJYeJoRj9WrvPMK2MrXkCkIwqgx1Sq6JlIQK2EXin4hmXSdIJrhaxay1Xt6U9HnguY0/5hP0DaIXIu7jpsfTbJRDaVuexua0Ge3w9bsBpXY0n2fzayylSQJKTMOPTIfKoIaIPtdjcpGsq5+uIe1A7G2mYFiN7K0fjL8djKKt+blpnKiSg3pxFKV4icFb7ocwbkyvRUJlnZADQIpzjZbXmU1juzhV9qADFHRQFSI4ivWmBnpANg6zXHBaQ/yN2YSU8/wCoLQdVM5po4VreDYCQA0cUnuHKnNw3tYvs9aGjbtFQwo8954AUNpXCMx/OaeogQfA10rPTlmLeCQJTER4tXc7uEmVBtZ1E/R9qi8wXyO1YYwGdveK20A+XYJe+BFSDQ4rBKVf8erQVWYSHc5P5xqSk9wdnXGFi6DoPk7RX4WGOle0+XVjf
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AMCPR10MB992291.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(23010399003)(376014)(6133799003)(18002099003)(261009223027099003)(55112099003)(3023799007)(56012099006)(261022105027099003)(261102123227099003)(11063799006)(261021121427099003)(261026121527099003)(261022113327099003)(261022075727099003)(261028144727099003)(261026140227099003)(10067099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?+oQ0iyvYdVmjloaIOg2vOGu106+cljCi0Eb+Dksg55P3ecrQsilgjvYNS591?=
 =?us-ascii?Q?nxPCcgYNcnMTrsQ92Uz92B1he1HadUCAx+hBAubOckSS6kqhZr1xxgagct7Z?=
 =?us-ascii?Q?S1sd2IdU3bHOwoKXY6j9GhGvY77OIKbTR3vKugzFkGuY1Bd5cQ1M8iGiPcRo?=
 =?us-ascii?Q?TvPrZYqjWln3hy0GbX0weT9WxrpNCJ3U8bpynE+XoYGgHrel41ieTt8naWty?=
 =?us-ascii?Q?+yY6F42zSNu6zz7zV6/vTy8Fd8POdfAn7aVopnM7t3eRknJLdvvVWbO4oqAg?=
 =?us-ascii?Q?4GTgxp7XaZqloVpy3nGhty08jkG45n1/ISNuM8xiZaaHdX4FU+Ymd2mSg3+A?=
 =?us-ascii?Q?Ld4ZHF/F/wdx2/Wko+KvTPKCIbUWBPKyHO4dmucSBA1/gT5UnKwlDfVECLMV?=
 =?us-ascii?Q?IqPKegGi5skJ6uy0dtdADpI4xGe5UCEDZKnFZfsRmnkqEvEngB+xEDSTtGy1?=
 =?us-ascii?Q?Qw97ENFW88A+pVjl+1WNKGEqJqA4tS8BuvR0XD1HFueUN/am+q+xNqxfokjV?=
 =?us-ascii?Q?FrW8KiSpPwKZHoasIL2MQdO9qU/3gURvEvS32cGLpjM9EZiT6uQzEcmnvUZH?=
 =?us-ascii?Q?I36D9SKS11SkjX4x+Fvcb3uzvBh5ZIo8zlyZN9qZFax0qaGgpvWVqNaA5mdQ?=
 =?us-ascii?Q?12tsFoNDT7QRM2sRqOEXqJp+inXXQkD4wGj2vjhY3SFHZD0ffandLS8Q48u5?=
 =?us-ascii?Q?sahClmuBAg719FA94gwRF6ZzBVOf4ztYwWD2r9VP8qIE+VmIAl0I70Qq+KbC?=
 =?us-ascii?Q?XyLhmeljhmUrQ+mxHcGCERgS7se7iFvLqvGkjtl2fJ7kApb4GLgO8bfxtwHe?=
 =?us-ascii?Q?ql+71ir1fZqSlIqShHWw5qU8HRyWQCg//VNQpbf8WCouI/h23cogjST7FDla?=
 =?us-ascii?Q?11x9aeH8FZpPY6ejfP1q16KHpvYQkcCjZzNJB1+n9V3qMD5utRrXp5kux3P4?=
 =?us-ascii?Q?yjdsExmC7aNPiZ/G1i1v/sjgW7vP3MmBNRtF3oeRIAVETSZBsdEAK1082GB4?=
 =?us-ascii?Q?24v2tPzbbqzxrMiTqCkvuIBy33WNR3rTYiP6b+hCMAgPnzNpXU27TCSh+udh?=
 =?us-ascii?Q?bDMZbLD+Ng1bIFWpeBDXHE/sTd5UBQHoGwOKJXWL0L5cLzWN2FRk3jwH3QD9?=
 =?us-ascii?Q?CJ4IM09cyoq3CF05miYVUVEm0MJOtUhjzywNXqRyee8qWC8Kxvn/Og8QNYUV?=
 =?us-ascii?Q?sKsJ395oSetV4BHOhpL4qrKPQTZ6Pag4O+mkfRxV1MAF+Gz65LYD65YYAwBb?=
 =?us-ascii?Q?9de3jS0qTOhLzhkS4n0tZUSj1wQiDkgw+2jUPDjskSxtMZmFsecv1FbirwFN?=
 =?us-ascii?Q?3gvV7+98UIqyl8f0g+rMMk10ftYLyLYudH6Vr6QxI9e4GvY1UCgWr/LhGSnV?=
 =?us-ascii?Q?tvD+yrK0Xc5mjcXwz8h9/IkVnQ154mZD9+Ew4MD1tL030ifFkZYsZdB3DVUR?=
 =?us-ascii?Q?Ck/D7X8qYxKeR9HEjYHSeWKeHWfECwSru1mHvbPTkRr1YWYG3O7So0y8GpYU?=
 =?us-ascii?Q?A/lFycmAmrUzGj/3Ujora1URkBRdRtCwXY2qd9XACYDIcNnt+X5Kz0ycmh60?=
 =?us-ascii?Q?VV/O9TNgwX66jAQJ8GG9yoUFvxUQmMHbyw3gk5xfyrbanAAK/hZVKqAtyrLz?=
 =?us-ascii?Q?5U3dUalTUmqs9rDcJqf4elCZYV52NaAmpyoH2GeK9GxVppWgtjVl0Suf4+xH?=
 =?us-ascii?Q?K4bvSXnxuEOQR5NbB3PEGL60Fdmhzf6DXKYryUIvX/UKiQn6+9LW/OGLxSUz?=
 =?us-ascii?Q?71uYCokcbA=3D=3D?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c77dc152-f12d-40ac-ccf6-08df44743864
X-MS-Exchange-CrossTenant-AuthSource: AMCPR10MB992291.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Nov 2026 06:30:06.3581
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HUhIlaW/axLK+P9N8mxE77vj2ou/fcTxyCE8G4m+WfwJ2ghYOmZ9pYhsqkV6+Bf3tE5dgY25cIfrdhN2x87I0g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV2PR10MB6429
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by lin-tor-korg-lkml-alma10-1 with HTTPS for <cip-dev@lists.cip-project.org>; Tue, 17 Nov 2026 06:30:19 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/24812

From: Jan Kiszka <jan.kiszka@siemens.com>

This describes at which time which ares of the CIP kernel are handled by
the CIP security team and how to report vulnerabilities to it. It
furthermore state the this projects falls under the LF stewardship
framework.

As the original kernel documentation already contains a reporting guide,
leave a note there which one applies to CIP kernels.

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---

Changes in v3:
 - s/as appropriate/as described below/

 Documentation/process/security-bugs.rst |  6 ++++
 SECURITY.md                             | 37 +++++++++++++++++++++++++
 2 files changed, 43 insertions(+)
 create mode 100644 SECURITY.md

diff --git a/Documentation/process/security-bugs.rst b/Documentation/proces=
s/security-bugs.rst
index 56c560a00b37a..7b38c83d932d6 100644
--- a/Documentation/process/security-bugs.rst
+++ b/Documentation/process/security-bugs.rst
@@ -3,6 +3,12 @@
 Security bugs
 =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
=20
+.. note::
+
+   If you identified a vulnerability that only affects a CIP kernel, pleas=
e
+   instead follow the reporting process described in SECURITY.md that can =
be
+   found in the top-level directory.
+
 Linux kernel developers take security very seriously.  As such, we'd
 like to know when a security bug is found so that it can be fixed and
 disclosed as quickly as possible.  Please report security bugs to the
diff --git a/SECURITY.md b/SECURITY.md
new file mode 100644
index 0000000000000..c67799cd54223
--- /dev/null
+++ b/SECURITY.md
@@ -0,0 +1,37 @@
+# Security Policy
+
+This project is supported under the Linux Foundation CRA stewardship frame=
work,
+as described at https://www.linuxfoundation.org/security. Security
+vulnerabilities should be reported through the mechanisms described below,
+which we will coordinate with our CRA steward. For actively exploited
+vulnerabilities and severe incidents that may require CRA escalation, plea=
se
+use the project=E2=80=99s emergency security reporting mechanisms as descr=
ibed below.
+
+## Security Context
+
+Open source software can be used in various contexts that may go far beyon=
d
+what it was originally designed and also secured for. Therefore, we descri=
be
+here what the CIP kernel maintenance is particularly covering and what is =
out
+of scope.
+
+Unlike the upstream kernel, the CIP kernel is maintained with the focus on
+architectures and configurations defined by the CIP project members, see
+https://gitlab.com/cip-project/cip-kernel/cip-kernel-config. Vulnerabiliti=
es
+found in code paths not covered this way are considered out of scope.
+Furthermore, vulnerabilities that are affecting the upstream Linux kernel =
as
+well are in the responsibility of the kernel security team, see
+https://www.kernel.org/doc/html/latest/process/security-bugs.html. In scop=
e for
+the CIP kernel are issues caused by patches not found in the corresponding
+stable kernel (linux-6.12.y-cip vs. linux-6.12.y) or that are related to
+missing backports after the corresponding stable kernel went end-of-life.
+
+## Reporting a Vulnerability
+
+Please DO NOT report any potential security vulnerability via a public cha=
nnel
+(mailing list, gitlab issue etc.). Instead, contact the CIP security team =
via
+security@cip-project.org via email. Please provide a detailed description =
of
+the issue, the steps to reproduce it, the affected versions and, if alread=
y
+available, a proposal for a fix. You should receive a response within 5 wo=
rking
+days. If the issue is confirmed as a vulnerability by us, we will request =
a
+CVE, publish the fix and give credits for your report if desired. This pro=
ject
+follows a 90 day disclosure timeline.
--=20
2.47.3
