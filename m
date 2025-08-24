Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A85C6CA0EEB
	for <webhook@archiver.kernel.org>; Sun, 24 Aug 2025 07:41:19 +0000 (UTC)
Received: from AM0PR83CU005.outbound.protection.outlook.com (AM0PR83CU005.outbound.protection.outlook.com [52.101.69.19])
 by mx.groups.io with SMTP id smtpd.web10.12557.1756021275998770645
 for <cip-dev@lists.cip-project.org>;
 Sun, 24 Aug 2025 00:41:16 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@siemens.com header.s=selector2 header.b=yYQZZKMx;
 spf=pass (domain: siemens.com, ip: 52.101.69.19, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=zUMl0WmgOhoMBa/0bJ+957Br3kXiLnc2QuDjjboRE4MMdjcmNO7RqAMukmXRAxGkWX+VurflREjiTlbBPKaYGBXz+VEMl9ayzoltp2ptAYq2chIq/G5HXJZkWSVPoSIbKloLmw0f92YPhBPOO5NrtmRKlsOYW7gDtgLEJV+cmr2cOMrOVmU2z0cvil8GVTQ6WJW75Ja6h7Bz1hUIjIQrBymV+YWZQ3NFxS7yk/440Ifdb8N6yW2MNiIcEkyJIMF2nrQKIlja4SyE4ugPqQ+py1ZLhJ8nUFSisSC2go14qIMaQTbXEP5Fb5assdXwPPjpQuNMQIr1tTQUImh7Zk4q/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tXoFwItC1tJndq7dWOaqaWYj8Y1HyFnMBEh+AgmHxkU=;
 b=DQtI8vBTfJVuGC9BAZwpgaFe4GL1nLFX3nbt5GsGTpM258DS+eBlId+sl+lMo99FCs/Drp+F+UYIwCQL9n7fmCT3TX64+pYibLcXQyjsbf4/yRBW08K7iub7SiaAmcMwxFD+kEr/PRgrx4o35ObPnbfsP55JqO91NzO5ifHh1Ysw7jId+78tTNhLbFpel6z8709xeyrPAibcKsjGucY0mxVqKfFRJyjnETgAxfwCXXd3pVgzowwxYfM4pyrA5RNnHhGa8JP8qp96c3bc3dE+WX76xsTMygs/BPVyyDRF1h5fn8NPTYh16Zq279ttA9v03So0Hi4bLyAMHjbeC5xLBQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tXoFwItC1tJndq7dWOaqaWYj8Y1HyFnMBEh+AgmHxkU=;
 b=yYQZZKMxQ+zFacGP9er1BHpotmF6Bia0R372tVwsKPOyB55P3P9qfYh4O/+RSJAmmfWuDBdUZzm1XHz7eb1yjkjwVO+OG/xoUL0TRJZPaL7fwJyKZXp+FubAWrvdaM2l9Y2faMZSsL7Zv3sJUkU1jLRK6+xJSLBiOfn2rZmN4ccZBigVKdsgHpQEdVFYBpFSi/xGXtZ8Ful5TcvPc1+FAv+pt4nOeHIBJtvQjdpPF5avesXS0ACvX9/VIk+t+z4CTsuPrP6RfeJeAI57u1wTJCcyKo3tFTlonRTHjJiRe8gGLGkvI9j4hcidfh1ozbrWIJXrHRRh6IWtByr8vovgYQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by GV1PR10MB6265.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:150:93::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.20; Sun, 24 Aug
 2025 07:41:07 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408%5]) with mapi id 15.20.9052.019; Sun, 24 Aug 2025
 07:41:07 +0000
Message-ID: <43295d5c-c939-42a9-a684-b7d7f3eed4cd@siemens.com>
Date: Sun, 24 Aug 2025 09:41:06 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/8] sd: Add RPMB emulation to eMMC model
From: Jan Kiszka <jan.kiszka@siemens.com>
To: OP-TEE TrustedFirmware <op-tee@lists.trustedfirmware.org>,
 cip-dev <cip-dev@lists.cip-project.org>
References: <cover.1756019920.git.jan.kiszka@siemens.com>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <cover.1756019920.git.jan.kiszka@siemens.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: FR0P281CA0005.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:15::10) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|GV1PR10MB6265:EE_
X-MS-Office365-Filtering-Correlation-Id: 52814f97-38ec-4475-6bc6-08dde2e1962e
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?dE4Wtahle+VC0ryl4o+WpyHKcfUsvJpnbLVh87svK2jJ7/y9I9KwSR45CFg1?=
 =?us-ascii?Q?0SHWQrncPCEXwPiC1Lr3NWinpSj/JP0eMO/rKNWHsFIAP2lJSAz0CTKHHJe3?=
 =?us-ascii?Q?hVl0bX06nuBCWJqiAVpdh8kh/rY7Eh4fSs3L6+5r6BW1ZDvrAFPqkyO/yRaO?=
 =?us-ascii?Q?MUvu+9IZ8cNjjKbG3VkbgB2tyII9g0128d/ryxSGbW/rcr1AQ6dRCudUK0wK?=
 =?us-ascii?Q?IgND3WZOuUDJs7/xTCN13k59IyK0pgTz8VZB8aqDpBnEUOZiFYLLByXcXfYM?=
 =?us-ascii?Q?hEHSU/BfJ95ATVyA8ScqQ60eyQlVm2RmGLOZ8NW0tj/Udx+YTM3QT6ikmitH?=
 =?us-ascii?Q?Cxos85nv6HyQjFGaFO5QI9trWs/6CtKzmnnoM3vGxfwNlcX6WitG1/aW9wOL?=
 =?us-ascii?Q?Al06HHvflEdesYVVGjjVGU90Clq2Ke2glULe4s/aob/g+2jj3rTHI48nRhnL?=
 =?us-ascii?Q?X31FHIDysb/ECKeH/yMklfrWE1pW9Kro4LJAuuWZRa08lfJ++P074uFqkypq?=
 =?us-ascii?Q?gpzfdmwv1XERCKhX8uLYDOZr/oOl/T3YGbrTSC5mx9Gej3ZpIJVX77l7RDzd?=
 =?us-ascii?Q?Mw+R/KM7rCi+rQToXhS5+aBBNoAKYb+8BVIR8Hru+bb87MctiU1dJwbfzkea?=
 =?us-ascii?Q?aRKS+uc+zhPvtBTgbSR60KvkhaNLsXrahNHvGR2DeD4/g9Iw9+oOXZBUQxpJ?=
 =?us-ascii?Q?4gsXYoG7JF0SYx2Rn5HodBRdYIR2GkwoC54KiIGe19+xF0Fsd7Th5Z/rSVXL?=
 =?us-ascii?Q?NqvqKrZJiRvjdo7BLrp/cpgseb1aNBL2CnnDejK+wWhhkqf232EiVrY70VwF?=
 =?us-ascii?Q?qLjpPTG9YsMh6oiS6lECprKPRoppzlh6pC4ZX+Vf9iwRplU322VHrXMF2Neg?=
 =?us-ascii?Q?Rqoke7HWFkR42/STl+iNdZYWtcnkq/xZXMewbgqU3m1KTRqoaVU8yreoah1t?=
 =?us-ascii?Q?+cSaBpi5r97lm8Cx2PwqdMkzl+2NNRWEtOYa7sWbF2fuBQyddH7PbdlOsmE2?=
 =?us-ascii?Q?HaoJgywMFpwpRJRc58MiH9hpiNEvtHcQAg6l8W9BhlDhFEP7xDGk1mxy9YRA?=
 =?us-ascii?Q?hrEsvkO9mv4GVoLObEJtS+cH8h0DjtoiMfp27zHx816fHtv/IFp3k4LspWIl?=
 =?us-ascii?Q?2wPxAzAwxCtAujFSoYkCZ/tQHazjOoPlU6glCSU/KtZPmZ3mqTQKSAAxFDdU?=
 =?us-ascii?Q?mRz61AoV/ogBcMv9cPC+gW3kU1Qk7eqfeT8vtEuU9OEC5/RyDwTyqEkLhiki?=
 =?us-ascii?Q?5H7YRm3xu09uYvB6OA6XBZAqrAwqK7UJUb+F14i61zl8ofp6GSvD63CkSyLY?=
 =?us-ascii?Q?+B9tKkoFYsG674EhQyXNVATRjrNqAw3qognlWzWyCCb3T32eWYRVYy3oUEFv?=
 =?us-ascii?Q?OqZRgo+7ilpMQ3aqFMP/KN1LIttSLQIDaIi5sOHQ5+iwe47fPplDoaGLdwSd?=
 =?us-ascii?Q?QnbYWUyTisU=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?YbamUFXK6U5hpDCD66DIiedDW8nUEzpBODR9O6xsJaQ8ml5WLpssCKGBcCAm?=
 =?us-ascii?Q?qxVBXpRrWfgdyo4/bxFHHrDnLLoSj2UuTk/G2oDesbR1hXuY60rp/mMlQiNC?=
 =?us-ascii?Q?FeyuuYbmnetGY1K0Ju3xE8uIGmzZNzm571JvpAAe9JL8Wwlwsmm5+zU33Zhe?=
 =?us-ascii?Q?mDKCKQHUCZ5A5vg6KOCJ0ZgFFgiK85U8FQKgeNQGJqdMqhf01UvPjrO8cOxE?=
 =?us-ascii?Q?Y/fBfVeOsUciHs6OklCrWdxEOLKl4oLO2Dz1fPF88HNkEjNMCyr7wmfUSukh?=
 =?us-ascii?Q?091fxSlKLhHmq65y6eXkFZfURSZxkFLsbEYCHXnOTRtixpEmBC02Z+bQ9FYi?=
 =?us-ascii?Q?lFNKzLHz4SzssqapECgH5DYqNly/7ZL7Pm0/YX9X5p3SPiqA3p5slZ/z5nz6?=
 =?us-ascii?Q?y1+fI3WTwhVTGRr7Ah57P8PlENgyuamG/JLnWizPvaqMD0Qcn7eOqb88xMjj?=
 =?us-ascii?Q?z7nSba7OW4u9CYs4kDQPJzJcoL3mFHyc3RwY7A2385PFa1FT7721/oXVcFxn?=
 =?us-ascii?Q?M2pAvqCZQjQMUt6pOLotz9rR6ovZ+sn7joqLPH1MxP6CUi3gEd4fF6zaFy61?=
 =?us-ascii?Q?AIlYK7D4i/AlQ0gA/r51TTajJ7B/jPIhRV+zx85ptPKBcCSqB6LrUg6A26PA?=
 =?us-ascii?Q?Oy3QkAhJrWYG5okpwD3wfVZcSZf3UFPaHVV5bVvNfkU+rFIc2FzYA28hKcIn?=
 =?us-ascii?Q?ObLcQs9ad7IXq//fxT9nsHoNC9vOPIaqGYZcI25VaTRtzvocWxhDmRfBc7QE?=
 =?us-ascii?Q?Tez8g14G5qggSZyrKBEXVMiFDJDwSDsuX41xtDJIEkuyrxP7KRrxQFe8CRM1?=
 =?us-ascii?Q?2LbFl6S1BopKzKIgUYzN4KOGTKHSUKbq5+lqWE6SEv6ObYF8DXyaqJd4kyCb?=
 =?us-ascii?Q?D7NE/qkg5v1f5Djag7AfZUWdO1zm1RlX2Gxklc2rKWrLsEWYgo7lfGcMW9eo?=
 =?us-ascii?Q?jjMHq7Qqbq+ord3O8j5rnpn/Qf1qf7ZrdgcP/EcUdet65hsyeUJVHGVkrM28?=
 =?us-ascii?Q?m4q0jEFG5iXg4vY5MnzdNIyMJ4mt5LM8gNfeFAAZWHwGaEqgNghndtFWpwPy?=
 =?us-ascii?Q?Xd33HTvXFHRraPpxbvFgar6iktR63fIt9cFILj7Y3RIOJ82jVaAflDeMNkXQ?=
 =?us-ascii?Q?uF484hAxAqtmDl/wlKGqm2bd2fr2PfqKxaaCUoRSvaAczYgkdJjiut90WhGQ?=
 =?us-ascii?Q?3QKjfO/qQ0ryS1UIqVEGsdIp8FYOY68n/qdNE0WZBnlsrK8edYD37U23nOHj?=
 =?us-ascii?Q?bUutclZQ8nWrdYlEhag9DUQGFj6BUBH+Lc4nacP10Vivnr1YDEiBRurjZrlR?=
 =?us-ascii?Q?7KzcrkpYP8QBzfH5IaTz+dItwydOemvW9X/VwChkd1b1qbB7gJCPfT+qwu35?=
 =?us-ascii?Q?/QBWdMrUJ8UDKgqzgBq1r66CkttkPvCSVmjrBDvXNYXFfi6ZLkR4QISOKrU8?=
 =?us-ascii?Q?u8GhxfTx486CvO3gIUsXTzf3Nhz+nUU866Sw11KuwYCCdDuEyT2+nR/5vZki?=
 =?us-ascii?Q?N7FakjUp2pDRjzkhlSSbtnHAho91xWlncPy0tdOT4JrjMp68fIi1Bq22FAQ6?=
 =?us-ascii?Q?w55hBygUOee3Bt3QTM4F7QAHRgL90jntUVyHJnDRSXhkxz/IhRiOlFbR/LOO?=
 =?us-ascii?Q?FA=3D=3D?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 52814f97-38ec-4475-6bc6-08dde2e1962e
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Aug 2025 07:41:07.4101
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qwvdxtsJJSdf4ySaxNpCR8COu2ac2ryDoxGizkyisqFv15GrJtL/zcKKXKkGDTsAPssj4uz1Sg+OVAbnfEQA8w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR10MB6265
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Sun, 24 Aug 2025 07:41:19 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/19956

FYI: QEMU model is working fine, upstreaming started, feedback welcome.

Jan

On 24.08.25 09:18, Jan Kiszka wrote:
> This closes an old gap in system integration testing for the very
> complex ARM firmware stacks by adding fairly advanced Replay Protected
> Memory Block (RPMB) emulation to the eMMC device model. Key programming
> and message authentication are working, so is the write counter. Known
> users are happy with the result. What is missing, but not only for RPMB-
> related registers, is state persistence across QEMU restarts. This is OK
> at this stage for most test scenarios, though, and could still be added
> later on.
>=20
> What can already be done with it is demonstrated in the WIP branch of
> isar-cip-core at [1]: TF-A + OP-TEE + StandaloneMM TA + fTPM TA, used by
> U-Boot and Linux for UEFI variable storage and TPM scenarios. If you
> want to try: build qemu-arm64 target for trixie with 6.12-cip *head*
> kernel, enable secure boot and disk encryption, then run
>=20
> $ QEMU_PATH=3D/path/to/qemu-build/ ./start-qemu.sh
>=20
> Deploy snakeoil keys into PK, KEK and db after first boot to enable
> secure booting:
>=20
> root@demo:~# cert-to-efi-sig-list PkKek-1-snakeoil.pem PK.esl
> root@demo:~# sign-efi-sig-list -k PkKek-1-snakeoil.key -c PkKek-1-snakeoi=
l.pem PK PK.esl PK.auth
> root@demo:~# efi-updatevar -f PK.auth db
> root@demo:~# efi-updatevar -f PK.auth KEK
> root@demo:~# efi-updatevar -f PK.auth PK
>=20
> Note that emulation is a bit slow in general, and specifically the
> partition encryption on first boot is taking 20 min. - we should
> probably reduce its size or understand if there is still something to
> optimize.
>=20
> Jan
>=20
> [1] https://gitlab.com/cip-project/cip-core/isar-cip-core/-/commits/wip/q=
emu-rpmb
>=20
> Cc: "Daniel P. Berrang=C3=A9" <berrange@redhat.com>
>=20
> Jan Kiszka (8):
>   hw/sd/sdcard: Fix size check for backing block image
>   hw/sd/sdcard: Add validation for boot-partition-size
>   hw/sd/sdcard: Allow user-instantiated eMMC
>   hw/sd/sdcard: Refactor sd_bootpart_offset
>   hw/sd/sdcard: Add basic support for RPMB partition
>   crypto/hmac: Allow to build hmac over multiple
>     qcrypto_gnutls_hmac_bytes[v] calls
>   hw/sd/sdcard: Handle RPMB MAC field
>   scripts: Add helper script to generate eMMC block device images
>=20
>  crypto/hmac-gcrypt.c   |   4 +-
>  crypto/hmac-glib.c     |   4 +-
>  crypto/hmac-gnutls.c   |   4 +-
>  crypto/hmac-nettle.c   |   4 +-
>  hw/sd/sd.c             | 314 ++++++++++++++++++++++++++++++++++++++---
>  hw/sd/sdmmc-internal.h |  24 +++-
>  hw/sd/trace-events     |   2 +
>  include/crypto/hmac.h  |  12 ++
>  scripts/mkemmc.sh      | 185 ++++++++++++++++++++++++
>  9 files changed, 530 insertions(+), 23 deletions(-)
>  create mode 100755 scripts/mkemmc.sh
>=20

--=20
Siemens AG, Foundational Technologies
Linux Expert Center

