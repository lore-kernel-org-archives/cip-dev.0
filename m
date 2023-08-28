Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 565C9C83F12
	for <webhook@archiver.kernel.org>; Mon, 28 Aug 2023 06:41:17 +0000 (UTC)
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (EUR05-DB8-obe.outbound.protection.outlook.com [40.107.20.83])
 by mx.groups.io with SMTP id smtpd.web10.8195.1693204867033939979
 for <cip-dev@lists.cip-project.org>;
 Sun, 27 Aug 2023 23:41:07 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@siemens.com header.s=selector2 header.b=K/ek0kZe;
 spf=pass (domain: siemens.com, ip: 40.107.20.83, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RWIE0KS319Qw/U7wbRkgNzwu8QD6AJqWrKXpeizOqdxyDDnfyQrh9yma14Wlehi/INQglHNyNc/fQqW3JO32Pq2vy2RmWcFkZ1TAiuYTtbN4jAjhuTuBAHdP4M9rQfX7CHMNuHdtDTdhADYWMgaO+wEzd7PemijCWPi4BPY/XMq8Y4C4PA6AozLFK23CuvP0lG5nOm79W91tHjItu/YjwyQL/LMTdqOK1fP/zDeyHPVX7zq0syvtNJtRgcQ+mhdg2KsYxW+XdIuoP5q11oNz86hAdOoeV1H7f0Jd8SDELCs+qnuRSMGZe1RLPKKWjrC1d5kf3YBOCDo7Ws6/922+ZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4iDf5ZutzavExRUe+I7SmCJMlG51qGOCzcG6+efImG8=;
 b=HRGVcfP7IOatYHU7T9drIst/Jux2HHUFRPhIbxt82r81XMu+i7ElA4aIWP5UwWJHisCWmmMjntSLBV+GNqBpTUVDXpVSkF8JuRflU2r+sy/ydYrVtxFaP8B3zqZDpMvxoBizLGzqcJS291rgqFNhMdXsyoDLRaLTjuClg6I1P/ZnWZhffOULlS+suTNel76GWpJegBDQNT1m6whKCZSRAFhXBVZqN7DD/MiQN5+mhWj/sMDhNutAKEJm1FU1J3Y58tSqUac4R7A/kX9zn8x+1uYniAnjkBKw7a6P/DhbigawO6IKw0Ahwp9zmB1mmcF88eOe+Q4NfnlTlDZjAnz0fQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4iDf5ZutzavExRUe+I7SmCJMlG51qGOCzcG6+efImG8=;
 b=K/ek0kZeoU6niey+n/6D8HITwdWSdPj6UepVbbFX0eM0rMFhh3qwetY0vTB8SCDrjYBwhb+Jhe64tUlLlIFY6DthyaKTquHmKmyoyEPS/0MqH+6BPk9sITsJHvYWo6hLIIRkQ1jZ8fhHoI+j2NXf8WhZoGAUP7bspXfjMQp5Iq0fASE2RsMNxXukJXZliNofnnGhu2U4gvGXoR5D3Z6tnA47AOlftJai0I7ZFoPVhOFgzF3oeL8rey12tetIy83xs8PnTc+RcFekj66GPqbdc2HkMwHvfGZGAjML98Y8ANlzjwJRYAaJiIIXpWZwtKZHjCcYex0f480p1YE8pKASMw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by PAWPR10MB7175.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:2f1::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.34; Mon, 28 Aug
 2023 06:41:03 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::7f20:d403:b43d:12e2]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::7f20:d403:b43d:12e2%3]) with mapi id 15.20.6699.034; Mon, 28 Aug 2023
 06:41:03 +0000
Message-ID: <33ca3eb3-a306-48c7-a13a-5c7a7f6de3c9@siemens.com>
Date: Mon, 28 Aug 2023 08:41:03 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [cip-dev] [isar-cip-core 2/3] Enable secured boot for BBB
Content-Language: en-US
To: tho1.nguyendat@toshiba.co.jp, cip-dev@lists.cip-project.org
CC: kazuhiro3.hayashi@toshiba.co.jp
References: <OS3PR01MB588051DBC3BEBB617CC6B0CA951FA@OS3PR01MB5880.jpnprd01.prod.outlook.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
In-Reply-To: <OS3PR01MB588051DBC3BEBB617CC6B0CA951FA@OS3PR01MB5880.jpnprd01.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: FR2P281CA0129.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:9e::16) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|PAWPR10MB7175:EE_
X-MS-Office365-Filtering-Correlation-Id: 394a2630-7c61-405f-3627-08dba791bfe6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	XeHDmVZRtcm25GR60Yjxld6YDBkIdwoYuFSE8ag8kA/F1HaCrY29s5FjBjoxTx2Ted7dH2C6/jHAXY4T2HTHEqJkQsxmBrBlTfbLUS3/eWN4KMQU26MhPqxmPxiiMa5QrCUztOzCJaQao63M/pfQ4YYprHGERSJT8zcKprqTOxemYhXcUuSEWxq5N2a4/U83au2S+I1CAWj6vrs1lLl+3mQXWJl6buFF3+pCBtEjBciQNxjsmGm0yaEKbFEGfSCLNaqmy9UIuY8ofz8hpn1+wB7NQ7VQj6Hb2hsbV0WF60GWrabILjvfbDyn55JwqjrKD4mz7GtlCZybYeKRNNhqMb6DDdb/eHxSpym7xajflWfL98HENV8UK9qmt4TC0CFSzN6dD4gHGKVy+HVtjgekXOrJWl5GUCwOil8YdVgyNXZh4mTnY71dePkFvtBAcrA8I5egvHkWQQRZlKQQfLR8bY8AegLRyj1B5MKMNUTTI9CrTMoS4gpcoQsw07dkDi/HNmMQsQq19MZxpKt27BeXiV3q/EiurHPpqiQATIpHeigGZLsW72wCf14xo060SCSGtCtY3dZYKPfvKnNzGF6hK5/umG6+HD9c9q/jMVLCQabWlR/HG4JchT0uDhCEGkJ7sIroyUOHQnNEaz5MB1fBz4kRd0NHYq2QfZApaqBzTtWIQRjGEdpAEe06SrjCqIGg
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(346002)(39860400002)(396003)(366004)(376002)(136003)(1800799009)(451199024)(186009)(8676002)(8936002)(4326008)(2906002)(36756003)(66946007)(66556008)(66476007)(316002)(5660300002)(44832011)(31686004)(41300700001)(6486002)(6506007)(2616005)(26005)(53546011)(6512007)(38100700002)(83380400001)(82960400001)(478600001)(31696002)(86362001)(403724002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?N9imAt81E6JBqhA//O0tPOk2Mrq2LaRQ09lbWtoOQrUkQlN4QPL+ywdddoB3?=
 =?us-ascii?Q?WmSfYIha/vJGN5WeQiXvcap8gED34RuouXJYnUVIkrFx9S2yNruOM0yn//Os?=
 =?us-ascii?Q?mX+jWpuHGdPtbyrJiOPgN0SxzlLNIzgNCC0tjAUBlzUCuDZCCBsmy+H2TOc/?=
 =?us-ascii?Q?XSFyj6TYe5Y6Mpox0d+yW4syyBPJv9qMixH2AyOsBuvX6SQeGGVMhdkXAZe2?=
 =?us-ascii?Q?qHjR3Opx+xIJ/CpARCrFW7qkId8RsrTbSfGWXMiSPg7p8d8bW0cGlDSi8SGo?=
 =?us-ascii?Q?7DmoSKoVs0ehTZMVx6DbNdtV8OoOpEvu25cIku/u8pdPgR/ypqYQkPI42Z3h?=
 =?us-ascii?Q?8gEhY81rt2QyUrDLNfEk290qPgMd96OQnp9mBUjcr3nd91cO3mSHEYGjJjot?=
 =?us-ascii?Q?u9UFZEe2JSNIKnYhi3m76tXMbSeeYZySBOo2kJDw/LFw7Of6jcP7KEU8Inw+?=
 =?us-ascii?Q?zqFKI4ODNU0EJrBt91cmnq495D248BF91VUusu5RkxMq0lxktI2XqYKDI8zy?=
 =?us-ascii?Q?XgVofBJg+fqtDcNQnpz0ejUal09Q0Z3NTJIN8s5tBb71Jph2y/TqxfgT9/4F?=
 =?us-ascii?Q?12t/bbcc8hmwuHhWSOnclHiZ0k1K2VVAKamZXChNJT2WuDfRTNx/qszCbNbB?=
 =?us-ascii?Q?Yzeh/DUI2UyKFGIbb+r94Wj5bf6cKl0lEiinRrX9eQSem2dyazsgeaB+nNuk?=
 =?us-ascii?Q?Wwhe+R9BgBu2apva7IM0kgUIYKafkQralsT9kkoEyUz8Q/VNKdAhGKNixM+v?=
 =?us-ascii?Q?n6neYlAIK3HTwW3T7HkcM6RnI9H5v2oxn+J84mOR18zsE5D3J4WLapIX+Hsy?=
 =?us-ascii?Q?MqMHay62Z/sHfDps+wjbXur6dJkjBR7ypK3DJTb5e6d16p0FSiz6jYAGq7lY?=
 =?us-ascii?Q?S4mSPufvE9gvG8NqAeF+1B45QKVACWdsIiaCk+bMl7FpN2WmZErF9Lc7r8ir?=
 =?us-ascii?Q?WQPjfUZ7GX8ob0tWXOys+nUYWzcuTJeQQBPTTHl8JY3O7qn9ccH8l4vNgzxb?=
 =?us-ascii?Q?6Y8P6cTKkgppe98PeYHdg36XMPGlL6j46Mpf3Xz909Adble+rZROqA1RRRCs?=
 =?us-ascii?Q?9/l3es8yNoNoFQAwZUgDpxrDyTAD5SY1ba+0omWuymPII1eMCcenq8CIMW+/?=
 =?us-ascii?Q?Br9cHM8Iusui2oW7CXnOPgUfCBWHYHEcBoDxlm8J2cqK+riWoekvwJoKkk8d?=
 =?us-ascii?Q?Ut56AB2kYvFB+yNjxWa/OQoezAR5mQjw9AtTddOalfLNUN43dWVIMtw+PuQz?=
 =?us-ascii?Q?gUx+bVwkCD3ULfIBeX4z2/5NTSYEinYeUuH5eYBAl80BUqkjTVvDhpOi4Z4L?=
 =?us-ascii?Q?WQ+0gcyrHFwji+knJ1fJOp5wg6x94Hr/cttVpEoYbe/MrPM6dfnJdRaH4sUr?=
 =?us-ascii?Q?zO99oNn8g/vWUYmQJXFVuIKo27MtLMKmf5bkueXWOD+OlsuEG8nKb0A6UYdl?=
 =?us-ascii?Q?QJPKWsPv1B2ccKevqX5X+b9JZc4PtgFI0OfIb76OOou5MMyka1fh0CID3/r1?=
 =?us-ascii?Q?jytGgmKD5VZfjfcNpcqz5Smxx52As2w1LkoALf+tr8IWRY/vpMJnPvR8LLsZ?=
 =?us-ascii?Q?F4iJEvT9Xs1BVb9EHQrjmDfDbWloEASXh1iFOJEV?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 394a2630-7c61-405f-3627-08dba791bfe6
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Aug 2023 06:41:03.6169
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Ol0mcZUWh9vxSPUe0mCj6YPBFZjujk4kG2f7yYNkxmr8HKDXYgmCF0u4dezwBbML6YFShr3bO3/Adt2V3yEv4A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAWPR10MB7175
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 28 Aug 2023 06:41:17 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/12873

On 22.08.23 08:54, tho1.nguyendat@toshiba.co.jp wrote:
> From: Nguyen Dat Tho <tho1.nguyendat@toshiba.co.jp>
> Subject: [PATCH 2/3] bbb: Enable secured boot
>=20
> Signed-off-by: Nguyen Dat Tho <tho1.nguyendat@toshiba.co.jp>
> ---
> =C2=A0wic/bbb-efibootguard-secureboot.wks.in | 13 +++++++++++++
> =C2=A01 file changed, 13 insertions(+)
> =C2=A0create mode 100644 wic/bbb-efibootguard-secureboot.wks.in
>=20
> diff --git a/wic/bbb-efibootguard-secureboot.wks.in
> b/wic/bbb-efibootguard-secureboot.wks.in
> new file mode 100644
> index 0000000..504e2d8
> --- /dev/null
> +++ b/wic/bbb-efibootguard-secureboot.wks.in
> @@ -0,0 +1,13 @@
> +part --source rawcopy --sourceparams "file=3D/usr/lib/u-boot/bbb/MLO"
> --no-table --align 128
> +part --source rawcopy --sourceparams
> "file=3D/usr/lib/u-boot/bbb/u-boot.img" --no-table --align 384
> +
> +include ebg-signed-sysparts.inc
> +
> +part --source rawcopy --sourceparams "file=3D${IMAGE_FULLNAME}.verity"
> --align 1024 --fixed-size 1G --uuid "${ABROOTFS_PART_UUID_A}"
> +part --source empty --align 1024 --fixed-size 1G --uuid
> "${ABROOTFS_PART_UUID_B}"
> +
> +# home and var are extra partitions
> +part /home --source rootfs --rootfs-dir=3D${IMAGE_ROOTFS}/home
> --fstype=3Dext4 --label home --align 1024 --size 1G
> +part /var =C2=A0--source rootfs --rootfs-dir=3D${IMAGE_ROOTFS}/var
> =C2=A0--fstype=3Dext4 --label var =C2=A0--align 1024 --size 2G
> +
> +bootloader --ptable gpt --append=3D"rootwait console=3DttyO0,115200
> omap_wdt.early_enable=3D1 omap_wdt.nowayout=3D1 watchdog.handle_boot_enab=
led=3D0"
> --=20
> 2.30.2
>=20

Kconfig changes are missing so that "kas-container menu" can select this
as well.

Jan

--=20
Siemens AG, Technology
Linux Expert Center


