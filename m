Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9133EC88E53
	for <webhook@archiver.kernel.org>; Tue, 15 Sep 2026 08:35:13 +0000 (UTC)
Received: from GVXPR05CU001.outbound.protection.outlook.com (GVXPR05CU001.outbound.protection.outlook.com [52.101.83.49])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.18681.1789461305933498401
 for <cip-dev@lists.cip-project.org>;
 Tue, 15 Sep 2026 01:35:06 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@siemens.com header.s=selector2 header.b=R8ojH41V;
 spf=pass (domain: siemens.com, ip: 52.101.83.49, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OGKQcYgpjsmNso/qcTfr9uhPqigmRjfCTjExIbSIyUwAODj2zHVbEjm0xtAkWU42o63SPCz5gN4Xsdf+//fI7MatvB/4QmccqAxk37PoGlaO50csr/F1Sj+1mJz7ER+VlfJlngWULjlJViVZxhR3DD84jQUBHxiYiZN+BmqiLgUUjU4kzLaBM8CAWl/ohrWYTkz1fQqPODzH5NcunKcfCR8VzBhOr3FW5PvstYczXiAS/2Xl12vncrTeCoD+ZWuQsGSDEeKI3I82baa1D8HGfvdO1eSLs+qQt/2Fd4Z4bIDnVxWAMCBlNAsIBXJLoz6TPHLwlu9/8Cd9RlUBXqsYQw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FzVzUG0lw4AqMsSINEhbl8/b/7CNiDG8BbajBsvbMeI=;
 b=VU5Af3xOAjbYZDHMpwnhuYmYi+M3gVAGIiMTTH9GSOSx7cuXL6xo3g1mxSxdqlpJpbkmOdeS814p00ttQ5v/PCxSgOjVXQfOBz6uIxDW+bBfxuj7I37tuq3sBLCvOLq2G+/yepKWg9ElzSQpeLMWILWNLnKrHuykS8bZSJyIhpkkPJmdvwgeomasm6B73ZdUltOI5IgnDcb1pzrrA1h4QDfqKufwo85+cd0JqchrfFzDSREuYCyk7ocgyW/QuSwi8PO5A5xYizXJVxhf3xDrUxN57s8jW0O2zRxeGcUwfqqOuKBJCbfDA9bOL53XVEQ57DyELG9Eevs4HlufmGsgMQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FzVzUG0lw4AqMsSINEhbl8/b/7CNiDG8BbajBsvbMeI=;
 b=R8ojH41Veh47GuPewXY167i2mhKXB9SF9TJ8UnXyFC792iqvmmYuo3xA6h1XuLIX3hC4dxyXBYY8g/DiHRc/IgfV62shI9j0UoLTevOgaDNWgMPdpoGK9I7nJUXC7HpNhvR0XpwGbLrA8pDEEi1+/0NlBjoo9FZjYmyqlwA3QfM771ddzykXu31fTnNiLpbbvw5Nd2MDgbkUvMhwr+KuJYKD9wgaKotc5b6s/rat57xzJuDKgta/ScLbUBMiA2JUskwou9kjNRvZ+8oF8/Ockf2B42cLp58Y/Xf05nf6HQtIr90K3TTVF/CLacQGB8rtZgsOlxdPmICgpdvKCx4MwQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by AM7PR10MB3779.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:178::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.13; Tue, 15 Sep
 2026 08:35:01 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::be9f:e8ca:ee9:83e1]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::be9f:e8ca:ee9:83e1%2]) with mapi id 15.21.0428.008; Tue, 15 Sep 2026
 08:35:00 +0000
Message-ID: <a1cfc8d4-5fb7-4f75-9600-92ebd7dbbeda@siemens.com>
Date: Tue, 15 Sep 2026 10:34:43 +0200
User-Agent: Mozilla Thunderbird
From: Jan Kiszka <jan.kiszka@siemens.com>
Subject: [PATCH] Add SECURITY.md for the CIP kernel
Content-Language: en-US
To: Ulrich Hecht <uli@fpond.eu>, Pavel Machek <pavel@nabladev.com>,
 Nobuhiro Iwamatsu <nobuhiro.iwamatsu.x90@mail.toshiba>,
 cip-dev <cip-dev@lists.cip-project.org>
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
X-Mozilla-Draft-Info: internal/draft; vcard=0; receipt=0; DSN=0; uuencode=0;
 attachmentreminder=0; deliveryformat=0
X-Identity-Key: id10
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: FR0P281CA0006.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:15::11) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|AM7PR10MB3779:EE_
X-MS-Office365-Filtering-Correlation-Id: 134df3c9-19dc-4940-14e7-08df13043b51
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|1800799024|23010399003|366016|376014|10067099003|6133799003|56012099006|11063799006|55112099003|18002099003|3023799007;
X-Microsoft-Antispam-Message-Info: 
	ADDhEFY5puOzuJp+QiWzYdOXRVOIUJJnYAhzIYGyRlOP5JEZ9OR/10//WT9SVTIFRrpgZ3ZjL2qZ+CHNekUT3zjWOE/XnA40PlKIxa1ckfHqci1iLu9gc3n+sbEK8w8Oz4sxBbZpcbzi0J6KoQXJvQtJISlu6HWWVRamDLTppC3qL5FGG/bHK9yHQIC4iLN05V8eFPynipep6kCijUffh7Lzh4sGcOaO345gfEwz7mnygXQLPO6QH8z7Ie6gJtD2yPbUlK3xVhpdWipii1ZnBka6XyJS7xngbw0uy83IpdhQnJBZeSXzoymDEHCj3D5oSlHzuvJPu88o4LA2OBUbnRlweBLX3kGLDj8nNX8ULsLUmbjBay20oEkkxOyi8vGsjndb9ce51kfQrgeG8GzfC75Nh4ik2fbfMxXbbo/RyOaF884GjYqfPudDkSTXa+wimjPLw3zzR3Rbf9Swl9yzAsSC4xmBKzizbng9pV+h22WRxXM94tFThDJX6ByctS1ucCdY6G7pc7pZPdfoUu1M41fLAc9C0kLg0VEt9SkDUVmcl3DEuTx3lGLTBx6VjEqZOjZ7phVJJ8mp3uOXwNYu5hgBIJ6ar2tpB/vruyf65wFrGivMzhD75T5yVcc248NcOUw442qf9fADOGa4CZBGNaef8uWNTs7QFrDGmtnjiYk=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(23010399003)(366016)(376014)(10067099003)(6133799003)(56012099006)(11063799006)(55112099003)(18002099003)(3023799007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?02le732M+STKtmQn8I8zpTseVZ9AlwZbhv1KmeVQaRB6X67RB//KV7Zm0jE1?=
 =?us-ascii?Q?laLX5uRVMT7WQgkuvpUjLRQqV2B0ZCexVSL8epXn6qrYHWiva39AUb/FsDGx?=
 =?us-ascii?Q?ZAN62kNtqeioPeZZ/YVjPghwiuv1oqNNKN3XKUe0YiTh4FSt4gbq1LvAWb+g?=
 =?us-ascii?Q?OoLz5IMOCaemGF12Dst0gD1o0K5HHlxC3PvbcJDlNz/5astyWxhtsQKbNZGS?=
 =?us-ascii?Q?C5qXIpJgMELfLHNc3Ij3osZZKWT4hBHCyBo9phJu6OkDNJaQYexKc5dtRmB5?=
 =?us-ascii?Q?FU6wKpw2k3jtCjQS622dWqApbrGPiH/UWB5FsreoM5fS3C5Xp/2rixk/IyXR?=
 =?us-ascii?Q?93vopbm8Ch8E0no/nvaze8DXjqlZOqHcIZySNTsUBcjNZ7ZiwBKSo9/G3jbT?=
 =?us-ascii?Q?SEXdsMmKVLPXVjpMwuzPKaBAYTLlHoAOEAQPybTj+1MoXkrJk2dK1MJX5+oK?=
 =?us-ascii?Q?wFVztGZkseLWs53QVoeDe8Ms0KyU9+JiJqZPd1KG8IS74VgL63d1+RsttMbH?=
 =?us-ascii?Q?RM4y1PyxXCodpvHwwVh/yWQ8tdfakgNpvZ3uE7XCM1IsKGrVAVUKdHznWqrv?=
 =?us-ascii?Q?LAlRAbAcP8E2fhWbOz4NaFt91J6wSovbrxCIqGQDm/nXO249mUAcbmrNRfMu?=
 =?us-ascii?Q?emIloq0FJ2/rMkfbFvtByRSbFJZaKGyeVXRPReOjmoD+CSRFyPWKI0KK9048?=
 =?us-ascii?Q?1fTPxJ2bmy7vbofVO1WA6DE7Cc19t/ej0VSV2/PnO2qS9b4/NEMWyI3Mde0S?=
 =?us-ascii?Q?1BGMgQb9KQVqcqU2EcCN3DzBEKEEco7nZbQ96N1zKcjnDllTJaYEXEYkZcEH?=
 =?us-ascii?Q?7ZoSKB9MrYxyPJabSVCyyowzjPRRFEImezOsr0eQn19RvZT3KHOJjf8FBm4i?=
 =?us-ascii?Q?h7e4vAnZRb+gAUQV0T574EqGRlehdJ9YtqXIvObpCdnpHFmkt0AU6fRI5FNq?=
 =?us-ascii?Q?RVxGjnJ/PyFJ5KVEc6anLCrEMUsH60RUynucE3Re8wnVOpSOuD24Gxn+FzGG?=
 =?us-ascii?Q?/nvJPpkFiFqg+/550z2Mh2eRLQ6HR89F2aRVHA9WfncWRffIwdxFF90O7PgD?=
 =?us-ascii?Q?RBfiZENBgZgrtincUBSh1u3aA/w9w6yrsy0Aris/XDY9aHKGAiH1i2w4Ym05?=
 =?us-ascii?Q?ZyU3nXnIZHWZT6rZyGawL2mcb3tAVQt9yQ//rGS1eR9liEHKlp4F/rGGBM+J?=
 =?us-ascii?Q?b30/yWohOoEfe34nhCKh6XQrRafUw/HZrZ1Ys6Soc5+t+6GxCOoCixq+PWjg?=
 =?us-ascii?Q?dyHtodoIPRdl/2s+lDbwADBq5AEtIbCR1nARiAz3boHyirInbXOf8g+D3mH5?=
 =?us-ascii?Q?kCZKEzkllV255+Pgd+BPnURIRWi+cOqST1E1DUznu0qBa69XIohExJcQoQCc?=
 =?us-ascii?Q?MFIsvKhjjaJ52psk+xYGe32AuNvlii3sCiXVZt/xhXhncskfhxantdxDIOS+?=
 =?us-ascii?Q?T47JbdJAFWOlufUt2lKQM6Nj5FTtlezxiJf83rjISkSbJNOSx0HLGN/ZgscW?=
 =?us-ascii?Q?7T3bNaH7e8+z54kQWKXgM3s0OrEO5JsxFgLoZgJZvZKz0ABpI3ncmUZLi6KJ?=
 =?us-ascii?Q?gyZccl+pA44crAlc1vDZM1A69NZeXir19kar/uvqauns72q4R7SQHiaZvv5B?=
 =?us-ascii?Q?cY7qwAmP6Nibd1S520mrjYt2k6qZyf2oItnm991csUQJKjA/LuGBuNFHj6ah?=
 =?us-ascii?Q?s/7o4GZbo2xdBQtyywXOW0xPFC8yy8BhsFdBOBuzrdpEH1u5Pr5fu0fU6yF3?=
 =?us-ascii?Q?s2/a7AsJEw=3D=3D?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 134df3c9-19dc-4940-14e7-08df13043b51
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Sep 2026 08:35:00.8421
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7zr4aB8cTwSSpoJG/0a+cXXLFOt8iRwxlCGduJcxuQB28f917XaZ6PtZY49hqsiDciJZk0j7En8H0SZZa51KxQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR10MB3779
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 15 Sep 2026 08:35:13 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/24180

From: Jan Kiszka <jan.kiszka@siemens.com>

This describes at which time which ares of the CIP kernel are handled by
the CIP security team and how to report vulnerabilities to it. It
furthermore state the this projects falls under the LF stewardship
framework.

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---

First proposal. Please review and provide feedback. If we all agree,=20
this should be merged into all CIP kernel branches.

 SECURITY.md | 37 +++++++++++++++++++++++++++++++++++++
 1 file changed, 37 insertions(+)
 create mode 100644 SECURITY.md

diff --git a/SECURITY.md b/SECURITY.md
new file mode 100644
index 0000000000000..f39a0178338ee
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
+use the project=E2=80=99s emergency security reporting mechanisms as appro=
priate.
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

