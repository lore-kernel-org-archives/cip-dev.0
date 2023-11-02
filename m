Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00C70C4332F
	for <webhook@archiver.kernel.org>; Thu,  2 Nov 2023 07:02:26 +0000 (UTC)
Received: from EUR02-AM0-obe.outbound.protection.outlook.com (EUR02-AM0-obe.outbound.protection.outlook.com [40.107.247.83])
 by mx.groups.io with SMTP id smtpd.web11.25315.1698908536849828112
 for <cip-dev@lists.cip-project.org>;
 Thu, 02 Nov 2023 00:02:17 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@siemens.com header.s=selector2 header.b=YCRB19Ai;
 spf=pass (domain: siemens.com, ip: 40.107.247.83, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DB1YjpRM4c3Shj6k/PpQ4SaJ8bU7vRE0N8Rh1VBu26OoDes3yhrNuR7V+g5kkZ32zh8eBehZF/ZmOVpI6aRPcsTlDlmYhuYEIjNBk6eqKXfvBdt2admKZ0DgUvjuiCuc9TY3Bej/qMQ48YUN+5/PowZmMHwEzKtRU0qUclnCC3/9J9BGOYJXV1WxoWjlBKd4ppEDmXh/se4dMvXJFPr5hWXzgdt496iGpnKHldCaYW/6cSJ3+i+/2VWq5GNjkE4Revk6zDj5nzOjyevMPf5F1YWYpomnLuFjzPkvpVht3havx8kz+Q72Zk/von0lnyg28rsKRaBuoud7CnEwycK4jw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=grwZPrn3IGiNvVWKhKf/o07zE0rYNquQ4MH4eqRiKio=;
 b=m9S4REWRdHhOZMpSurz6u1A/RZCH1Cud13ZwA2dorDz3Y13rVWpCfLWSaj22RX5m7W7SyzdEXsqfo6YBkSCDcRqF99ViSB1DwCAWeGmH9EBWliCO9HODZH7991/v5u6JwDx7A7xdPSnvS5nz4GNPZwiKZeSQT5J+B5/1Nio0Np+o/ltFlSYhKcX0SxtbFs7Fl1GlVZ5d9g0vdIKVqwwZtVwviTQLIBEJ5W3rHkhkmaA4woqgLCf1CG488xcAGEIb/4DXY0mDfx4srRCCJ/U4F+lsfkQSKG32cLAJF6Sfu4z7vlxnTwwsrsiUU28Qdrvl/v4mgSrf/b7qVFIDQ5tvtQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=grwZPrn3IGiNvVWKhKf/o07zE0rYNquQ4MH4eqRiKio=;
 b=YCRB19AiUdsEFIZYJxYHUl5jWcncnI11bcOHeeojLmj9w/ckADLAUKaNKZfqLSHbkUldJJ1Bh6m0Ewv9XluZpW+K0cH4uSYJ/eoS3jdrzX0uxEGVVkPfMlepOgQbqCZRV9YlMhnmHiZwOydp+QyqMjPCg0TTRgYdPGECuEw2NHmb3m7mLGZfIfP6JD0nsrOCJ3z8QzCVDu524DK0HKOTKrJRaV7hiYXJ0piC+PD8p5Pp6tVKMVPsOKmDsO74KWhJdkkXfPD9kyFPCkdvDFWc+E14ignrnZkz4hOZYP659ruLn9sfm9zvzeTz2EB3VyxARywHdMZyrZVNZ5Ww6DTcWg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by DB9PR10MB6404.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:3db::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6933.29; Thu, 2 Nov
 2023 07:02:13 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8496:a3a3:d7a8:b24d]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8496:a3a3:d7a8:b24d%4]) with mapi id 15.20.6954.020; Thu, 2 Nov 2023
 07:02:13 +0000
Message-ID: <49c7b36d-373d-4000-aef6-e867820b26e9@siemens.com>
Date: Thu, 2 Nov 2023 08:02:11 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [isar-cip-core][PATCH] added pcr_bank for clevis
Content-Language: en-US
To: "Sari, Sercan (ADV D EU TR C&E)" <sari.sercan@siemens.com>,
 "cip-dev@lists.cip-project.org" <cip-dev@lists.cip-project.org>,
 "Gylstorff, Quirin (T CED SES-DE)" <quirin.gylstorff@siemens.com>
References: <DU0PR10MB6898A9738AF1110D653D5DE5F0A7A@DU0PR10MB6898.EURPRD10.PROD.OUTLOOK.COM>
 <f1a52e61-3404-41df-85fc-7453be0d4be7@siemens.com>
 <DU0PR10MB6898C5AF36094F948A282906F0A6A@DU0PR10MB6898.EURPRD10.PROD.OUTLOOK.COM>
From: Jan Kiszka <jan.kiszka@siemens.com>
In-Reply-To: <DU0PR10MB6898C5AF36094F948A282906F0A6A@DU0PR10MB6898.EURPRD10.PROD.OUTLOOK.COM>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: FR0P281CA0235.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:b2::20) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|DB9PR10MB6404:EE_
X-MS-Office365-Filtering-Correlation-Id: 3997b0cc-0251-4bbd-76f8-08dbdb71a412
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	wY7MAVh8ROowomK+B1v0bmw4qsLaE2BIs52ARNwrUOV1FYTQfUnZjlF9Rk4ut/nCYPNWuElsiLYb7ZjklH6lzCj4V4XCCqnC71OU4t0s7fnz3UxAnnWeWB+AjckH87B2GoyS+mB2rJ/2RxtBAibMygChSUOkij0JBKVjGL633zp46S2jQ2ZQlyrTtFiskkThEaF3dUWbHxZldCzWhLGa1H+Q5D5YMeanoFzzVxhrs/HsSv/rdkRlMXTbM/p3jZ+uc8AhiyHSGQrVbiV9Nbe/B2RWkJIUoIacIbWb4XaYva5sbkk9iyyMIUeTa9bVf1berp08wk02coEo228FLAqDdjUWWaP+PBVREcQ5alrMkBLpb58bfnOcK5Bj3guOMjFYWs2kfZ4fat/RgV5nWRjrDcWH0M9LcD1UI4Jv6RbgtP9H3CkmsTPjcidCJKlFSrx/tF3L2+pXtYbPiBKzz9sIyarMdSS4q5zAwtnulu+vnbUuKc/mmIv6TQXUeOG1uq9uyUKpqR9gOS0rgxambAD23hGHuppZ34Lg1YPazkEdzzDlplM0/R4GDyGMQndS/6PUKyj7EE0XSKeOYv6t7kX6r0x5yKfHCA6p375sIpeqo+xZa0UyVE9HImbR0Z1Hf/A5I0gPjFj+NEaU0ksizP8Pof5YzsirkiiEoh/YnChLiUM=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(396003)(376002)(136003)(346002)(366004)(230922051799003)(186009)(64100799003)(451199024)(1800799009)(6506007)(26005)(6512007)(53546011)(2616005)(82960400001)(38100700002)(36756003)(86362001)(31696002)(66574015)(83380400001)(8676002)(316002)(6636002)(66946007)(2906002)(66556008)(110136005)(66476007)(8936002)(31686004)(44832011)(966005)(5660300002)(6486002)(478600001)(41300700001)(43740500002)(15398625002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?H9wmsVGajpkVopzTImmXoL/6vh5N2YfkPGkle0KTWHrTv3aOo2S9WXzEl+Jx?=
 =?us-ascii?Q?yG6ZKLHoqPatF0OygPdGfblsmxqLMZnPSh1TEu49agNzL/zD2od8kv/1TNSd?=
 =?us-ascii?Q?hvPwAutEB6RCVudeTgIVmBxK94X8lNgm7dxfUJ4RAuVnpwC+0r/INyt0rKDt?=
 =?us-ascii?Q?1wsQscYJcKQ0zvUX95iOpPYedlubSWXb1q1eZOYnOt4xMHsGB8TGYpC95uSq?=
 =?us-ascii?Q?ZCkU3caBT/SKUOK3NiBAAUPuTSGFcXmuUijDdt2oVZaccIlRroJCrGxKoTKA?=
 =?us-ascii?Q?fiwqi5KxPJDM/lTU+c4ood+hZDC/q1wF6WAd3CNfL0JGS/eIYXuP0WJFuWuK?=
 =?us-ascii?Q?1dMBLaL6AwNI231nh1eem7Qdai6GFDObnur2O4E6pmjVdsjZsYVoEyMjfad/?=
 =?us-ascii?Q?kf0isIDNqXRQCreIaWOI51eQIVij3H1z6PcixoOobpo0OhgBtgVsysGnE+iA?=
 =?us-ascii?Q?AulM+Y/K+hJoJEqedM3mzgM7u9rHXWWRhFhClhCzitvrX3qA5J7QU6s/giMq?=
 =?us-ascii?Q?iFa0LScx5L+C0gVo+lfZCaWB4yNyexe5/JRgUtSlMreaXX6soixA7rN77gqj?=
 =?us-ascii?Q?plCqgwR8fNmfV/wV1ZZxAw9KvHhc7jl2wM3BhneslqQPPHhg0OUOP0h7YYbD?=
 =?us-ascii?Q?xMaqVl4bTZsBOzECvpV3fFxUNtFZiPFmPFn5i6dhDo+6JzD7dkFxHv7MljVJ?=
 =?us-ascii?Q?ErsvRZ33BckGIHmyZ8NL08fVG0u07VGwx2uSN3zO8+1OI7EZcb76j/g4y44o?=
 =?us-ascii?Q?r8XPQdHQsoEXgvU8/b8IDzWPNSXwNc5CmdA9aNd9AbNbaOUpXL11o5O5v3VQ?=
 =?us-ascii?Q?p3Bf6wUV9oxHBXMl61/XDgxiKVYV/X5AVs/BCnpqtb3ULvJzSX00EhE7xJEF?=
 =?us-ascii?Q?GXYS5ornoOJ31PkcGUUrPVRjYAZg5EWXRksMnbLnZ+ZlLgPKEsjiMFGxhr8W?=
 =?us-ascii?Q?AaAWXb4TRD6YzlXshlURzCHuxvCJck28WEFSSanR5VwrviQrCxnG/CP5WKT5?=
 =?us-ascii?Q?7nRXuoTxk3mSwv7DjHPUys6xZ7YZHVma2j3GsWWc3byoNDR/+xMyr5pHcqov?=
 =?us-ascii?Q?iUJbsqv8j9JA5oD7LM5mj/2Ufhl0IvHT1Ep2IcEpROfPqvxcHwc1YzhUpyUV?=
 =?us-ascii?Q?UllOJO4VFnyyC3WVpCvn3UD3K8gf2IDSR40KDyi3A5NjHMujZDDReXFZhQNN?=
 =?us-ascii?Q?ZF7qHUm0baRj3Y+ITpiWm+5dG9ypkHF+hj7rQMJzHRPCHOtM+iKut184ePyB?=
 =?us-ascii?Q?xRObFRj4fspGGsycbzebDBiWXZAF8PrlxdGsXQmvrHc51Cuurs9u1D6AjhH0?=
 =?us-ascii?Q?rmjv8OCF+DOVrLhW8MHR3gA2SjWuTOVgi2ZdSbdIRCQ0UGlA/a8jo2NkmzZS?=
 =?us-ascii?Q?6XsXzaAR5+QUM12HCoqxnqvRZ5rmIhXri1O81IvQg8ck5yh7y8n7pCZOJIzh?=
 =?us-ascii?Q?pfvP9ixKwxdrmSjUP12pJLGDfoZvikJVyGZWOIwvBEFGbYvTosUwBYPCeiPj?=
 =?us-ascii?Q?66yX4Bfbg6M+6Rcze0iskUUM4ZoHmF8MZ7Zgm5cyPI4Jhd/ki+7ik3s7yrh7?=
 =?us-ascii?Q?j1+RQw/LbRwkgqci6/76UjrcdmXffDJGShAqfO6XfRNwakqyhTU/feW3Refe?=
 =?us-ascii?Q?xA=3D=3D?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3997b0cc-0251-4bbd-76f8-08dbdb71a412
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Nov 2023 07:02:13.5372
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 37Xm3gb6Som0AiOMuCRdWQBozF9TrtDHgeeq7U0cFFVOJTePOh/aLyUf3NVaLuvizPyXh3X/hPY21CUaCd7dug==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR10MB6404
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 02 Nov 2023 07:02:25 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/13512

On 02.11.23 07:45, Sari, Sercan (ADV D EU TR C&E) wrote:
> Yes, it is definitely open to a discussion, sha1, or sha384 may also be a=
pplicable.=20
>=20

Is SHA1 still an option today, from security perspective?

Jan

> Please take a look at the 4.7 section: https://trustedcomputinggroup.org/=
wp-content/uploads/PC-Client-Specific-Platform-TPM-Profile-for-TPM-2p0-v1p0=
4_r0p37_pub-1.pdf
>=20
> -----Original Message-----
> From: Kiszka, Jan (T CED) <jan.kiszka@siemens.com>=20
> Sent: 2 Kas=C4=B1m 2023 Per=C5=9Fembe 09:10
> To: Sari, Sercan (ADV D EU TR C&E) <sari.sercan@siemens.com>; cip-dev@lis=
ts.cip-project.org; Gylstorff, Quirin (T CED SES-DE) <quirin.gylstorff@siem=
ens.com>
> Subject: Re: [isar-cip-core][PATCH] added pcr_bank for clevis
>=20
> On 01.11.23 18:17, Sari, Sercan (ADV D EU TR C&E) wrote:
>>
>> clevis will fail to encrypt data when the TPM has multiple banks, such a=
s SHA1 and SHA256, adding the pcr_bank information resolves this issue.
>>
>> Signed-off-by: Sercan Sari <sari.sercan@siemens.com>
>> ---
>>  .../initramfs-crypt-hook/files/encrypt_partition.clevis.script  | 2=20
>> +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git=20
>> a/recipes-initramfs/initramfs-crypt-hook/files/encrypt_partition.clevi
>> s.script=20
>> b/recipes-initramfs/initramfs-crypt-hook/files/encrypt_partition.clevi
>> s.script
>> index 899f20e..957a3fd 100644
>> ---=20
>> a/recipes-initramfs/initramfs-crypt-hook/files/encrypt_partition.clevi
>> s.script
>> +++ b/recipes-initramfs/initramfs-crypt-hook/files/encrypt_partition.c
>> +++ levis.script
>> @@ -61,7 +61,7 @@ open_tpm2_partition() {
>> =20
>>  enroll_tpm2_token() {
>>  	if [ -x /usr/bin/clevis ]; then
>> -		 clevis luks bind -d "$1" tpm2 '{"pcr_ids":"7"}' < "$2"
>> +		clevis luks bind -d "$1" tpm2 '{"pcr_bank":"sha256", "pcr_ids":"7"}' =
< "$2"
>>  	else
>>  		panic "clevis not available cannot enroll tpm2 key!"
>>  	fi
>=20
> Is sha265 the only reasonable setting here? Just asking as we are hard-co=
ding.
>=20
> Quirin, any remarks?
>=20
> Jan
>=20
> --
> Siemens AG, Technology
> Linux Expert Center
>=20

--=20
Siemens AG, Technology
Linux Expert Center


