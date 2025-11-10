Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CDF9BCCF9E3
	for <webhook@archiver.kernel.org>; Mon, 10 Nov 2025 06:16:11 +0000 (UTC)
Received: from PA4PR04CU001.outbound.protection.outlook.com (PA4PR04CU001.outbound.protection.outlook.com [40.107.162.57])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.42176.1762755368103848369
 for <cip-dev@lists.cip-project.org>;
 Sun, 09 Nov 2025 22:16:08 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=UeP94JI7;
 spf=pass (domain: siemens.com, ip: 40.107.162.57, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=trxT9qBrt/Ra+UGDO4cvCdpXkb31VGbaCN69p2QhZWLyHlpi0hKxsTkjockC7QixaNhFknvnj2t543FuttA99AhgZIq+9uwnrVdEJ5HP82COVlYDma1vpDOgitwabS6c9xEOuD6vnQ7Zrc0orNxckOP2FjYz5hTRgvr7ky5LY6pPj54gHEd/J/Z0HMPZyb6vjB5p3vTtfKY/6903BSb4MYBM0i8Hb6HhGFhLShwZDwinPK1fZ3lKkK5cm9oOVOpLbI0FFyuoA2BX6dgS+o8Oprx6addzA8XWAXxy7CfuHn2H+XpgPDOSebuXz88192ACHjwyz6EO9IMqPaTJlrQjAg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Irh9cG63ALLTIL6Nz8SQTV4ro895Y9knnAvbBrqWJq0=;
 b=PZbScfDHMBYqu35gGqE+sB9MYxznz/njFIcPU9v/0J6FJMW2FODW2cgyTo3+ae1idBlEaffD2jvuIu6kRm2kB2Sq07DxbUo/57wCK1iHBxWnrvkuczNOXip4X1di7UORMg5UX9PlU9EhrwLAXxtke2z44SdsM+ZAqnqhVejSIFSoQi1jOgvV5FNW+jPLBidYaT97h9f7bkY6rXeYzMmQocTzyUnTUNFXPLuuXa1XvVknCHm7Zf55SsGlBBrvZBAxmS2/U18Ase8FqCzjro59tiu8appLZq6kaOIgrTlH9RkEe2Y0OMXUIlOjbL+mKlexEduVTjCztMUIDUPOptTEBg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Irh9cG63ALLTIL6Nz8SQTV4ro895Y9knnAvbBrqWJq0=;
 b=UeP94JI7febVBX0lCuFnYfRGyuQ6Kn0TPuXWyztL4UfyFcswqcxGiJIcdCckmPkVPs+Oaai3R391hHTNCXpA/LtO7xj3glWTwjaxLBffjKKdxQSus/RL/BQcYLF+a1gZyOMWZg5yRjmnur+pU30u0N5/HvXPsYF/6CfcIrrCSIJc5vP7HvoO4GjKYUN1smZJK7YNSrWQO9PiAubuwn/9fdHePvlIE7RnqhHBDhfM+lv/ixCfJZvKBbTR/xA1eBTn00N3CMafR+WNe8m98viGBPFQJJxGT9iSHsw5B85cCAk9C8R/ltXN3DX6dZDMBw4Bbgll++plC8KgsYcsGTu8+A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by GVXPR10MB8082.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:150:114::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9298.16; Mon, 10 Nov
 2025 06:16:04 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408%6]) with mapi id 15.20.9298.015; Mon, 10 Nov 2025
 06:16:04 +0000
Message-ID: <e3eac383-21d2-4cd7-ab73-e08ad53e42f4@siemens.com>
Date: Mon, 10 Nov 2025 07:16:03 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [isar-cip-core][PATCH v1 1/3] scripts/deploy-cip-core.sh: Support
 deploying artifacts for RB tests
From: Jan Kiszka <jan.kiszka@siemens.com>
To: Adithya.Balakumar@toshiba-tsip.com, cip-dev@lists.cip-project.org
Cc: shivanand.kunijadar@toshiba-tsip.com, dinesh.kumar@toshiba-tsip.com,
 kazuhiro3.hayashi@toshiba.co.jp, akunuri.sahithi@toshiba-tsip.com
References: <20251108111517.752691-1-Adithya.Balakumar@toshiba-tsip.com>
 <20251108111517.752691-2-Adithya.Balakumar@toshiba-tsip.com>
 <25d8c857-fb9c-47b9-88dd-7450cf4490c3@siemens.com>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <25d8c857-fb9c-47b9-88dd-7450cf4490c3@siemens.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AM8P189CA0005.EURP189.PROD.OUTLOOK.COM
 (2603:10a6:20b:218::10) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|GVXPR10MB8082:EE_
X-MS-Office365-Filtering-Correlation-Id: 03c14e6a-fb3a-4aec-8082-08de2020a0cb
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016|7053199007;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?VmIzSDhXbEgxZHZwQmtzQUU2UUt5QUU3OGk2c2tuVFZPTnlIczBycGRFcjJF?=
 =?utf-8?B?ZHliSEdWQ05uRURNY3h0YVhpT1pMVEloVmVVdXVleENDSlR4YkZORVlRbSts?=
 =?utf-8?B?bW5KZXFoT0VrSUR5R0JlVTlkRHY2ZTBSSmhCMS9IODg0L0VhUmYrWjI4eXpW?=
 =?utf-8?B?VjNvcnVNb3JpQk9PWlpVOGZPcVNGcGMxdnlNNEhRZHVzanFJQUFlb05IUFkz?=
 =?utf-8?B?YmxYYlovdk9hZUlPUXdHYk44Rys2akRZcFk1VlRaNjVDMkVqL2VCaTRWaXhH?=
 =?utf-8?B?OFF6bnorY2Z1ZDFMUGF1MGoyZUE2d3VBTEVQcWt1Z2Vnc0FPbjhrTjAwL2VO?=
 =?utf-8?B?L3h0SVBYLy9va3FPSm5UTENuYTVVUWhRYjY2cGlOTHZ5Ym9ZU1VZQzFzV2RQ?=
 =?utf-8?B?TEpWRFg5c3doZXg5UDREOVVJUmRyV3RMaHlkaXNMYm5xekMzNzdXY0RINkMz?=
 =?utf-8?B?MmNCdDY0andVUHBVTjkvZUdVOEpTS3VYWnMzdUZTZ2xQclZmYXJHYkZiQ1Zj?=
 =?utf-8?B?d1kvOU9TZHVobFBwV0YvRHlHUHBPK2FlcW9aV3I1SDUzYncvOU1EVkZaMjRD?=
 =?utf-8?B?L2twVjNMMzA2VU1JeXg1czZYb1k3U0QwVGhqMXdQeUthcy9oYUViL0E5N0VE?=
 =?utf-8?B?Q1VlN3c2QXI0YVJweElETkg2QmpCMXJoSHhjSG1xd0wrYVNra1RYY1dKZGV5?=
 =?utf-8?B?Y2I4VGwyNnR0eUdJcXdVTm40b09VbU44TGF0ckhuNEdRTnJoUEEzUWJQZmJO?=
 =?utf-8?B?aUZOUnR2Zi9GQ1Q0alRCSE16STdiSXpQdGpmWmhUdklFclY2dm05Q3pRWmds?=
 =?utf-8?B?SWVyMldtTXNZaSt6VS8wbzF1RURxN3FKRFZlL1l3ZzM4Y2ZKNWpRTlhtT0lN?=
 =?utf-8?B?UHNtWnVKcVZjb25xUFUrd0lJYjFXUTFyZUJ1SVhiM1VjQ0RHMm9lV25SejJD?=
 =?utf-8?B?Nk1mVFVSRlZDbXc5K0h1cmtkSEdqRmg0R0hwak1aZG8rZkhmMFltanhrWUZk?=
 =?utf-8?B?eUdHOTRkeXJ4WWx6aWZXaW91QjdZZ2YwcGtzdytuRjZIcUpLcjkveWJoTnZY?=
 =?utf-8?B?RVg0L3dEZklCcnVMaVIyNDlxMnVVYzU2dDYxc1F1YVJFdm1yRVE0L0U4YVFr?=
 =?utf-8?B?dUNiT0o3TWRJekM3dnhsSjJSU0JHYkFMZFc4eUlEbFFFVnJQNHJpTVRqaWY4?=
 =?utf-8?B?VWNNWVBzdE5yQm5vVUpxZXFaRmhVUWdLWmdqSklicHZLSFJxYWszZGVkL3o4?=
 =?utf-8?B?aXcrYjlKTkV0TUhFWkxtZ0ZsanBmUWNUL2ZTNCs1K0RHTUZYenpackFJbEVu?=
 =?utf-8?B?YjU5N1ZZNy9MbnZXYVhEMlZqL3dXclFkTHRuS2FhMnE4RlVET1lES296cjVj?=
 =?utf-8?B?dmFOQ2wzZTNaSWxZelNBajN2YWNxUUJXSWNxTGJuay9EdXdGWk5IWmZhM0s2?=
 =?utf-8?B?eFBEOTVRNm9DQmhiNlAzZ3h6QWN1M2hmNThCTjE1enk1K1AwMlArZ21KZEYr?=
 =?utf-8?B?SS8zMGk3L3hzY3FFZE9CSzFTU0tVa212Z1lYby9hcC8vZXpBUDE0cXhCTnYr?=
 =?utf-8?B?bGY3OEIxNk5ianloOERWbjZpTE5EOEVRNzFadEYydVZoMjl3aXlMa1FvRzE1?=
 =?utf-8?B?cVJNOXRwUXk0bm1sMHdjaXFNTWhLSHFSMktGTHNIOGU2eFlDNmdEd1BjWHln?=
 =?utf-8?B?WkY0UDhGdWtzTVVxNnUvNzZoaHZ1YlFUc3d1TzBEbUE3cHE3aXdBcWVTc0tP?=
 =?utf-8?B?WTVPdUs1dnh6QkZlN2trZGFmeVBSMzRCQ05mamdXY0tvVFRSRTEyYmJJcTF2?=
 =?utf-8?B?SlE5cXZPZHNuVFZqU1hoUzk5dEZ6bEN2NlYyL1NjcmhwYThFUFp0MzBJZUtK?=
 =?utf-8?B?NDdudFRZMU5CNHpMcUZ4dzVFamw3bHBWdFBZQk90OTFCdmZvZTZ6T05RQTFw?=
 =?utf-8?Q?60QXYxibqDEBKc9L9P7BeQoZzZN2UHHz?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?Zm5CZEJuWkMzL2ZDRjA5cW9YS3VJc0FHSUdHY3JGZnNjeXoxNEdUcC9ZeWR5?=
 =?utf-8?B?YUM1bEVvUlNwR2RHejlIL3c1ZE11WVZEZjRIUkpZaGxpYXJLTmNnSGJlekdu?=
 =?utf-8?B?cnZ6ZmR0VGcrVGlRV0xLRjJmRXhjWlA3WHdPbFRBWkpVUVZVVVFqREw2UFdp?=
 =?utf-8?B?TGFIN1dKSGVIWGhXcHU3MXA3NW9rRVZQbG1tTlBsVGxScE92UmRzb2ZmcVNt?=
 =?utf-8?B?Z0FVQkl2SlNxcmdCKzN3YkhYQ3VVWGZoa1plVlIyWTVydkV3bjdTWmQ0SnN5?=
 =?utf-8?B?VUh3dXNMWWpOOXdaUkhiSUxYRjA2WmgvQk1mZC8wTEdPb0krN3NaaU41Z0Ro?=
 =?utf-8?B?Z2kvRjArcEJRT0ZqenFubDllOWRycjJoL1JmSjBNT3ZWRC9MODFxWEUzTWhD?=
 =?utf-8?B?QUtxbGZnb0Y4eTFCTXo5bFI5YlRYRkZJbnVGd1M1d28xY1lxbHVGcDBzcGdO?=
 =?utf-8?B?MzlZRnh5QmpoQ1R0Z25lQjRGcEJYbTcyNER5azZvYkFvcWRpeVFtaS8vN1dF?=
 =?utf-8?B?eGIyTUNtNlR6UXdGb3pXNktlUjlKSS81clNTdkRKMXhZVDlCazFEQ24rek0w?=
 =?utf-8?B?SnBVTktVU3RiRk1QZnV0dDNCWU5xRXphb3hwYzdxVG4wWkY3MUh6WGZxeTd4?=
 =?utf-8?B?NHZaV3h6dTRLTXB0bnBBejhMMWtmUTYvOGcyQm5ocFIxbG80dHB1NWRLaFFR?=
 =?utf-8?B?UlhwY0V0cGt3dzE0V1VreEUvZG5mdWpNOTVKcUsxNG1XTGNXNityd0p1RVBk?=
 =?utf-8?B?a1UwUm82RUR3SXo5L21LcS95aEp4dlkxdHQ4RThWRWNuUWY0RWk2Q3J3NjA5?=
 =?utf-8?B?bFZVaTVLeDVKeFgwcHY5VTdTcDlpYTgycWxXUk9DODJsTmdFdlRBNFhMYnpT?=
 =?utf-8?B?WG14QW0yYVhTbWhyankxTXdHMGpjSkhTTUJTZWF5UlJNREROTllSa3c1MzIw?=
 =?utf-8?B?bmxaN0FXTUdFSnRzR2JrclcvQjFtNkthT3JvQnVudWtGa0RsQ3hSMC9YZUxh?=
 =?utf-8?B?RXBWczRKLzZ5amJLQkRVSVRiYVF3WXZ6NXluRU5XMS9DdWREVTRxZlorN09j?=
 =?utf-8?B?RDRzR2pWTVFDMk1JNXJNYmR1QmtoV3EwZU8vVzVxN0sxR1AwdkUyRmlOWnQx?=
 =?utf-8?B?bFhIdk1RMjM3dVUwMmVCQ3JsR2ptRlJsOXdObjB6ejBOR2JCMTBMQW92NkZw?=
 =?utf-8?B?NjZjNlFLbmV2VjNTQ0dlSEh6NG1JUDZLVm5lbG1QMVRzTHlFNHRYcjg5WTJQ?=
 =?utf-8?B?Qm8rdStWM25qaGhQRC9jcXArT0dkWWNIc0o0ak9jWDRlOVY0REpUUmJEaVNx?=
 =?utf-8?B?YVhaTGJ6MmRTaXA3eVA1ejZ1ZlFOb01KcmVteUNTQmp3VXRVK1FQN1daRkVY?=
 =?utf-8?B?Z3VXSjFsd0Q3V0RsNlVLelJ3WC81T3BIaFI5bGJWOUdqVWQ3TXc2RXRyd3gx?=
 =?utf-8?B?UmJNM1RtcXVzZHV6Z29wT1hvcnVoNm5TT0NUT2s5TDlUKy8wWmhWYzQzL1A2?=
 =?utf-8?B?amd2SVZuZldkTFZkMHV1WEYrb2FaVUR1Y01NRVRZL1JMMERTcHFybHFpbTdr?=
 =?utf-8?B?UW92YlRPVzBNSUJrMVhXNkIxNzducEh4M3E5S293QngwNXZiTU1JVXpFN2V4?=
 =?utf-8?B?emo5QzdFeTNvRTNIZHhSZGduZzFUYWR0cnozK3BROW1MZEErQnY1R3AzNWwy?=
 =?utf-8?B?WDFibjlpeHdFdkNpa2c0bElNYzZQbmtZcFlYUHNqY0NPQnNKSUIyWVRZazVE?=
 =?utf-8?B?a0NDYng5OUIveHV2TExiUGVBbG05RXYvVHkzdk9mbmMzeVcrdFp1bkxZUGVC?=
 =?utf-8?B?YmpkZUtudnJoZU42VmdKTm8wOVN2NG9qbkhXSlF4cWMrc2VZWHZ2ZDg3QU9C?=
 =?utf-8?B?Y2xhdTgvTXdETjVXM0xUV3N4T3RVNUJyWDBwOUdMdFZmOFkreWkxMFF3RVFD?=
 =?utf-8?B?NXEzNmRsUGJEbnI1KzRXQlVlaW81WGJ3ZHBHNURzUWYzUGkxS1hnMFlqWVlK?=
 =?utf-8?B?bmw1NmZRcmdTSnp4cmZIeUJ1RzhON29hMGkzSEhWQVM3clhRMXBoTjFRS0lH?=
 =?utf-8?B?TFRaTnkwLy9KUkIxcnRCZ3lIZEhsaHN4L3hRaGRpbGdIemEzQ3dqNi9DWjdW?=
 =?utf-8?Q?PM6IyaS6AbxGOmeW+fZQHT8w6?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 03c14e6a-fb3a-4aec-8082-08de2020a0cb
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Nov 2025 06:16:04.3436
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: q5tLgPsqB7fgsjXeTo7xJahqYfRpnoEHju8F2ThZScAh4CCFKGKEo/6QWkrVT5BAck4aJlq4XCPA4MoDtWpnWA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR10MB8082
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 10 Nov 2025 06:16:11 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/20484

On 09.11.25 11:10, Jan Kiszka wrote:
> On 08.11.25 12:15, Adithya.Balakumar@toshiba-tsip.com wrote:
>> From: Adithya Balakumar <Adithya.Balakumar@toshiba-tsip.com>
>>
>> RB tests require two sets of build artifacts to test for reproducibility.
>> Let's support uploading two of artifacts to S3 when RB test is enabled and
>> also support uploading individual wic partitions which are useful for the
>> RB tests.
>>
>> Signed-off-by: Adithya Balakumar <Adithya.Balakumar@toshiba-tsip.com>
>> ---
>>  scripts/deploy-cip-core.sh | 21 +++++++++++++++++++--
>>  1 file changed, 19 insertions(+), 2 deletions(-)
>>
>> diff --git a/scripts/deploy-cip-core.sh b/scripts/deploy-cip-core.sh
>> index 5647381..aeded7e 100755
>> --- a/scripts/deploy-cip-core.sh
>> +++ b/scripts/deploy-cip-core.sh
>> @@ -16,7 +16,12 @@ EXTENSION=$3
>>  NO_KERNEL=$4
>>  DTB=$5
>>  REF=$6
>> -DEPLOY=$7
>> +
>> +# RB specific variables
> 
> Please write out RB in the comment.
> 
>> +RB_TEST=$7
>> +RB_BUILD_NUM=$8
>> +
>> +DEPLOY=$9
> 
> Unhandy argument ordering: You now have to provide all 9 args, even if
> doing an SWU upload. Make RB_BUILD_NUM optional and keep DEPLOY at
> position 7. RB_TEST is equivalent to DEPLOY = wic-partitions, isn't it?
> Then we can stay with 8 args max.
> 
>>  
>>  BASE_FILENAME=cip-core-image-cip-core-$RELEASE-$TARGET
>>  if [ "${EXTENSION}" != "none" ]; then
>> @@ -30,6 +35,10 @@ fi
>>  BASE_PATH=build/tmp/deploy/images/$TARGET/$BASE_FILENAME
>>  S3_TARGET=s3://download2.cip-project.org/cip-core/$REF/$TARGET/
>>  
>> +if [ "${RB_TEST}" = "enable" ]; then
>> +	S3_TARGET="${S3_TARGET}rb/${RB_BUILD_NUM}/"
>> +fi
>> +
>>  if [ "${NO_KERNEL}" = "enable" ]; then
>>  	__BASE_PATH=${BASE_PATH}
>>  	BASE_PATH="${BASE_PATH}-nokernel"
>> @@ -51,6 +60,12 @@ if [ -f "${BASE_PATH}.wic" ]; then
>>  	echo "Uploading artifacts..."
>>  	if [ "$DEPLOY" = "swu" ]; then
>>  		aws s3 cp --no-progress --acl public-read "${BASE_PATH}.swu" "${S3_TARGET}"
>> +	elif [ "$DEPLOY" = "wic-partitions" ]; then

BTW, why are we still pushing the individual partitions? I though
diffoscope can now handle also partition tables, thus complete images?

If that is true, we should push the wic images instead, and then use the
presence of an 8th argument to control if they are deploying into a
subfolder to allow build 1 / 2 differentiation. If that 8th argument is
missing, the artifact is to deploy flat (and only once).

>> +		# deploy individual wic partitions, helpful for RB tests
>> +		cd build/tmp/deploy/images/$TARGET
>> +		tar --ignore-failed-read -cJf "${BASE_FILENAME}-wic-partitions.tar.xz" ${BASE_FILENAME}.wic.p*
>> +		aws s3 cp --no-progress --acl public-read "${BASE_FILENAME}-wic-partitions.tar.xz" "${S3_TARGET}"
>> +		cd -
>>  	else
>>  		echo "Compressing $BASE_FILENAME.wic..."
>>  		xz -9 -k -T0 "${BASE_PATH}.wic"
>> @@ -100,4 +115,6 @@ DPKG_STATUS_FILENAME=${CI_JOB_NAME#build:}.dpkg_status
>>  if ! echo "$CI_JOB_NAME" | grep -q "$1"; then
>>  	DPKG_STATUS_FILENAME=${CI_JOB_NAME#build:}-$1.dpkg_status
>>  fi
>> -aws s3 cp --no-progress build/tmp/deploy/images/"$TARGET"/cip-core-image-*.dpkg_status s3://download.cip-project.org/cip-core/cve-checks/dpkg-status/"$DPKG_STATUS_FILENAME"
>> +if [ "${RB_TEST}" = "disable" ]; then
> 
> DEPLOY = swu

Actually not correct, we also push this for wic images.

> 
>> +	aws s3 cp --no-progress build/tmp/deploy/images/"$TARGET"/cip-core-image-*.dpkg_status s3://download.cip-project.org/cip-core/cve-checks/dpkg-status/"$DPKG_STATUS_FILENAME"
>> +fi
> 
> Jan
> 

Jan

-- 
Siemens AG, Foundational Technologies
Linux Expert Center

