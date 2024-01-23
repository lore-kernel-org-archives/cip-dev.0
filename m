Return-Path: <quirin.gylstorff@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C9E8C47258
	for <webhook@archiver.kernel.org>; Tue, 23 Jan 2024 09:24:27 +0000 (UTC)
Received: from EUR04-DB3-obe.outbound.protection.outlook.com (EUR04-DB3-obe.outbound.protection.outlook.com [40.107.6.74])
 by mx.groups.io with SMTP id smtpd.web10.8163.1706001865064092091
 for <cip-dev@lists.cip-project.org>;
 Tue, 23 Jan 2024 01:24:25 -0800
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@siemens.com header.s=selector2 header.b=fSnyW4/O;
 spf=pass (domain: siemens.com, ip: 40.107.6.74, mailfrom: quirin.gylstorff@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MmZF5BVurxAnflsMmmp2AFga7t+eBGR5oQUv/V2ZJV/Tc38bvpc+pXM4qs0E/I7Eg8MYAWIePS12kMcDGLvsbXdj+ibPJOHqE0h9SIoYE/riiuRJVbazuaMkiDBgUQMVSHGT7rKOJjrgXFS7M+WLRHvnDVl+y7D3LqHsTCVzpDkuAspQTGYUD37VjTe0GI8cde94X8uynKzt0E+FYq1WEtJu/TH40yoUxSNLvSSHFGrrAmctFpl0JhuGUjE3dco6fZ9Kc70BK5Yl1JACwYy49Naq0lCJHA9WukyKsDq60iFcNogQWZPItH4cR4LN2qp6M/WmtZaHGBCWkDVizhhC2A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BfSwWxvGNQpneGHknOTBDs8Pxu7uTXlOpesm8H1QuaE=;
 b=beM387LwH7014Tt94UuSzP0t4KQ1h1kHuQj67J6NefUci+CRxJVg7qU3pP1Ui3ZDsOao8XNx6Nt6NmY7FlfdKBrK9f44ipSeeiEtXDEHuhwu8Nexxv/rY9DrcA7cQfAVM2Anitm5bHIxzHHEBQ0+DbrTTGb7iwRLqYYzA6tbaXrUePqZyGqL5IS9C9o0KQAGRn54hIAo9Gkl1EOiNycA6OsX58fxICy2pcT5ubFTdEo9PDw7mUCPftgDCAA4UQJ9OETF1kn6AgP3vMgdWzeHZCRzziJ+CTiswMTsWm6KKpgpXHG7003gqaotAQ1EzpthRk57HWqlrvP4Ta4au1WKZA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BfSwWxvGNQpneGHknOTBDs8Pxu7uTXlOpesm8H1QuaE=;
 b=fSnyW4/OZAEwMQg882WWEzttpvUB4qJLicwI9pBN2vUADxmEmEEYbC5Zc6vi6bDjvy20G89AUp8M5QmNkodH6EXs0oz6Te7Tmgb1PW9UfRpYAeJzHzwXGo8LYQyGijFfOiIdV0GL3G/0xhVfRfDWfRaGIdmCzA+vVnwS4FVUOzKkerjJLEmScy8xnS4TW2Ta/FJNCrFUuac9uiVKikXS9YTOLrePZrO2sGztoOYQPtNOyaNDNFu+ZZYLA74FiMujk60eHkqWXtYIOQNkGXQfpzdTCTO3NZEcIZyJteptnUabjnNF0c33t0yZQFEFMrritZ4KNaOjdw6qlrK7h9YARw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AM9PR10MB4085.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:1f9::22)
 by VI1PR10MB3326.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:803:139::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7202.36; Tue, 23 Jan
 2024 09:24:22 +0000
Received: from AM9PR10MB4085.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::5c76:8089:1f9b:63d9]) by AM9PR10MB4085.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::5c76:8089:1f9b:63d9%4]) with mapi id 15.20.7202.031; Tue, 23 Jan 2024
 09:24:22 +0000
Message-ID: <c6b7e6a6-28a0-47e6-a996-9112e767d9ae@siemens.com>
Date: Tue, 23 Jan 2024 10:24:20 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [cip-dev][isar-cip-core][RFC 3/4] swupdate.bbclass: weak default
 assignment for SWU_HW_COMPAT
Content-Language: en-US, de-DE
To: "Moessbauer, Felix (T CED OES-DE)" <felix.moessbauer@siemens.com>,
 "cip-dev@lists.cip-project.org" <cip-dev@lists.cip-project.org>,
 "Kiszka, Jan (T CED)" <jan.kiszka@siemens.com>
References: <20240122123751.83696-1-Quirin.Gylstorff@siemens.com>
 <20240122123751.83696-4-Quirin.Gylstorff@siemens.com>
 <bbbf2ed11c8eaac108e935f199c8acae2ac97817.camel@siemens.com>
From: Gylstorff Quirin <quirin.gylstorff@siemens.com>
Autocrypt: addr=quirin.gylstorff@siemens.com; keydata=
 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
 XSdq0hnpafc1V+voPJq3LMxUvLNrwg==
In-Reply-To: <bbbf2ed11c8eaac108e935f199c8acae2ac97817.camel@siemens.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: FR0P281CA0072.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:49::9) To AM9PR10MB4085.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:1f9::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR10MB4085:EE_|VI1PR10MB3326:EE_
X-MS-Office365-Filtering-Correlation-Id: b89866c1-12bc-4e78-b2b4-08dc1bf5157f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	Q4fEvgFjHYOxFjOfeeZzNf7lmwY56CgZjT3m4v2DniniXVNR615KGV0XkT/O8Ilom0SFlx+TBcWYTUsTgQVQGKxzS/5+YLiL/83ZuXG4uDY21N+wMWcthr9mr8JCcsrJeL5auWrnQvGkseWiKwvVx2pnvUKYfMDNga1WG2ixDGYvCtQeFWYUMMWaLLsqd7oW6PcRbJmo3S4Jz3mGwAqxcn7endOgmVbIVsZ8wcUPvy8xY/QsWASutajsGJ8tRjQ1ihBUBoK4hyIi89uo/Cdf78GupfW9j9yX4wJbGzModGk8Onb8XU2nFdzFeD5bnKkfbKdaZWJ8Tadzh48gheCdE4mjzwKGN96auuG7Ijl+0pmqDoLT6HqmqSku1Y951tASYlCZJcpRUw/yeIp+WthmKScXouZzYpNC0NLpc0GOlS8ftw5H9+8W1KXWUZM9nIsIk707SNLo+P1hmqTyym0kq+VTPD5A1kCqniNYlpQ8QrSmi24D3q+LLt7k4Gcl0iFQCG+Be5yFxvGDbvbonR1xkzD2zTQyC30e7snFzJSXcl5hIvMlt9cBuTGNUwehCqEW5R8Qgtkho5Z1FJBKkJ/4GJQeckq/8nfUiVwQEncfuR2pkfwZedwX1IQmutc9SEBMwrv5AzYy0WVIuUxbkiBNdA==
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR10MB4085.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(396003)(366004)(136003)(39860400002)(376002)(346002)(230922051799003)(64100799003)(186009)(451199024)(1800799012)(31686004)(6506007)(6512007)(53546011)(26005)(2616005)(31696002)(83380400001)(38100700002)(36756003)(86362001)(82960400001)(41300700001)(5660300002)(2906002)(66556008)(66476007)(8936002)(8676002)(110136005)(6636002)(66946007)(6486002)(478600001)(316002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?V/nh5rHyAZ7ZA/lVfQd/KKCK3/7Sqh8RTKiV/fYkK74a0Jz/GE4ReMYORN7I?=
 =?us-ascii?Q?VfzlvBCFFofVCRZFwDJbthZ0ZInGQshRE1LNciOUGu0MsiHctzRQL4ZvTgRX?=
 =?us-ascii?Q?MRWhWZT/ylddFznc4mXqzs+uWrUnAcYaOUtZgd0HbXD7aATser+a/QvXqLJi?=
 =?us-ascii?Q?8Z/ZsSebsQMixcNBnEch0h+reZVSi6gzPhcOJsZhpTzr6cY8bxxSFStyKS6x?=
 =?us-ascii?Q?XC+3fsvdKvjt8SkWimduQKs9GKfNA8GwboSQoqaENyuYxLhufs5xUewwxKdS?=
 =?us-ascii?Q?kcTH/HeBeA6IBHcGT3/OtIclciAfM5feFrL4N2wnuJWeQfMIpu94MaTx/7BX?=
 =?us-ascii?Q?B0334xXv40MZ04MUgoSjpMoAv7DW34UuEOuVv0eRyPQapjXE1t8nrTitzX9/?=
 =?us-ascii?Q?rZHF0fayX8I/AgV1If7oovg/yYLxrb2wU41YjeXip4+285vUCkBDCGzRe/DG?=
 =?us-ascii?Q?tlCgQHsjt9MOhx2cqDKubCzFK5ziKkDTOC1KvQGh0d31QmurBoMpa+1kxipi?=
 =?us-ascii?Q?RCI0ObkQ6bogXDaC3l13oBEEnLtqxb2bqM7M+tGWiVxrnGTYuvePladbUahV?=
 =?us-ascii?Q?2NmqMGaJyJE5k/jL02b1onb8VxMez4zS9VIXETuQousfao859Ll3GR8Z59lP?=
 =?us-ascii?Q?lL91fScoWYxNI/76JP4qRV52ooftzo6zzAEy8Kj0yqL5QYFxPVGdG7Znvu8o?=
 =?us-ascii?Q?JuX7PTnqoEM/ouqiH/Uw8eJfX8HFihQnNyOAA/b0aXXZwmin7sMR+wCfDCg3?=
 =?us-ascii?Q?yInexGhAwAoQTVypCgVQC+G6b+uAJpyCaScPGQmZk1PiEa+8fXFPl16MUZhY?=
 =?us-ascii?Q?rBSTiEkvff3MO50GPniM/BHdlUirseA1Ibl8xaL8OgVha8NQIFJwM9b+8XFw?=
 =?us-ascii?Q?uB1eGq1v+hR48Jpfk+KHmy2OzKFFGg+yqKJg6muTM/y4g+V8Nf026Q45THF8?=
 =?us-ascii?Q?KfsNShTJrGkJHnS6watTyUO8NVbONao61YNYvULJ8cRbXcc6pyY672lUcGef?=
 =?us-ascii?Q?VCYH7mcPlYAKn2aSEGYBCm8159OpkCqKW2sNumwn4ha8EgEkSD0HQo4YxFjr?=
 =?us-ascii?Q?n3ba8VZAegL07138N+q8KXMgZGbeAdbq7aBkhEy2quOOu43rD8v5lPEJcU+6?=
 =?us-ascii?Q?/0DcROhF42O9RZhCkhQB6kFs4+pJS5yPaTw6vXb1rcZytXLiUO2U0HOvdHfy?=
 =?us-ascii?Q?b7J5edi0WJwdQ5sYo1M7iiDncENyVKRCxxWtgdGaSoY3o+Ak6oTxSmArKYCV?=
 =?us-ascii?Q?VolP6IYVsM0aNocHNXspqiyu2oCXt9k3ETShNqEidcOsca+ndOQdFEKhd10T?=
 =?us-ascii?Q?peWcisOluktC2KDI4gAFSXh4U++ZQqnLoP/ITobwmoX8qptfV3QuyYaZUaJQ?=
 =?us-ascii?Q?wktrIWUqWJvQtcR8fDCY1+2Ckrp1biFGp4y4XByjvfcwk+gcFP5FTdMeWb5X?=
 =?us-ascii?Q?JKkwCTg94fnxPSTj+H1qT8ERIW8kAOxdC1IFtHTBV/xbJ2V8Mk06Lfcl3zdB?=
 =?us-ascii?Q?CpKloQk9m4wVEtFtRWBd701jpLJLTTu2WR4KZic6/o/U6MFcEjbna98EfrsU?=
 =?us-ascii?Q?cYRkGCBLCKa46780qCE0FcVghXpG7CMVmmWjstZTqEIaHQvkDPk2ZrcFt/cw?=
 =?us-ascii?Q?GQ=3D=3D?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b89866c1-12bc-4e78-b2b4-08dc1bf5157f
X-MS-Exchange-CrossTenant-AuthSource: AM9PR10MB4085.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jan 2024 09:24:22.2611
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Qtr6tpu68G5moxsjUnIcXjTpMcQvvGufgFiA480YU7gAaWRRk/8Z9mZaZNHfMITAKr93JOZHMQZXqhoVizuqI2Vs2m53RHmrrv03+OzoBKI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR10MB3326
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 23 Jan 2024 09:24:27 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/14443



On 1/23/24 10:18, Moessbauer, Felix (T CED OES-DE) wrote:
> On Mon, 2024-01-22 at 13:37 +0100, Quirin Gylstorff wrote:
>> From: Quirin Gylstorff <quirin.gylstorff@siemens.com>
>>
>> This allows to set SWU_HW_COMPAT in recipe-core/images/swupdate.inc
>> and in downstream layers.
>>
>> Signed-off-by: Quirin Gylstorff <quirin.gylstorff@siemens.com>
>> ---
>>  =C2=A0classes/swupdate.bbclass | 2 +-
>>  =C2=A01 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/classes/swupdate.bbclass b/classes/swupdate.bbclass
>> index 8f1215d..b2c10db 100644
>> --- a/classes/swupdate.bbclass
>> +++ b/classes/swupdate.bbclass
>> @@ -21,7 +21,7 @@ SWU_ROOTFS_PARTITION_NAME ?=3D
>> "${SWU_ROOTFS_NAME}.${SWU_ROOTFS_TYPE}${@get_swu_co
>>  =C2=A0SWU_VERSION ?=3D "0.2"
>>  =C2=A0SWU_NAME ?=3D "cip software update"
>>  =C2=A0# space separated list of supported hw. Leave empty to leave out
>> -SWU_HW_COMPAT ?=3D ""
>> +SWU_HW_COMPAT ??=3D ""
>=20
> How does that play together with the less-weak default in swupdate-
> config? Doesn't this need to be in sync to properly work?

This change allows to use the default assignment it has at that point
no functional change.

Also you can set SWU_HW_COMPAT to a list of supported Hardware and the
MACHINE_HW_VERSION from swupdate-config can contain only one value.

Quirin
>=20
> Or do I miss something?
>=20
> Felix
>=20
>>  =20
>>  =C2=A0SWU_EBG_UPDATE ?=3D ""
>>  =C2=A0SWU_EFI_BOOT_DEVICE ?=3D "/dev/disk/by-uuid/4321-DCBA"
>=20

