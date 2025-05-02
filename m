Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D362C3ABAC
	for <webhook@archiver.kernel.org>; Fri,  2 May 2025 08:29:27 +0000 (UTC)
Received: from EUR03-VI1-obe.outbound.protection.outlook.com (EUR03-VI1-obe.outbound.protection.outlook.com [40.107.103.81])
 by mx.groups.io with SMTP id smtpd.web10.14498.1746174559961176285
 for <cip-dev@lists.cip-project.org>;
 Fri, 02 May 2025 01:29:20 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=eh01LGcJ;
 spf=pass (domain: siemens.com, ip: 40.107.103.81, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lslPXZVRlmq18i9DBqYQiiQnf+LqMOulbGm40Xeblq2rANeVFw7pXwsTt0sRnTlaHPzu2bVYysPL4RUHyN0KSa6EV+afyPP3v6Iwtns5Q/txDNhiXai7oFCyZXSq4dnOtPdPUUU3D9L6sXtvU8SEmfGxxy1IEdOZki+xTFUBcZlrNMq2meWfLZepO8vFmqlVAxF8KviaEqtLeCpa4buGkgyPzxnfLB9Knv5ddESnbP98PA+vCNMcTH3/1kEEe1EfdiKxXHiiiQ/50yxIJP1Jz2UOv1+UW2OKhz5RBamJu8T7pBLXgVxjofuFuzwmKP/keSYavmh4OXxiQDHeT5eb4Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=a9UyjXxhcxCnBEhIEsDoX6qCm95IQQC45HgJBPyoSY8=;
 b=qA5YRAzT9ejBwLcda4td0n5PKxOX7qL+Hxh9xbbTS9PeuncoEEu3VLhcwBUhYm+5AYXWpSOeO5Q0i+Q9fUY59hWiPet5zxZUYwwOhKGxe2V9Tq6NW8nnZKlZXjCoiu0TW0s0RM3rzJeny5AcqnC3n2Ii5fARN8gcVkswZa9bTInSo5SrtULiRbZQp5V2ycNmUIYuui7HHD0vbUdPtiEMzev4Em05QqLEvDOC4dVdnW/eG27uNYfPaY6dSCJ5NhjC0uje3DHuOv5Ju8nl1IzrDxe/Zz+Gsl87MSZCnPvot9VVogPIDP+M0wGPnnCXuT+JNaNBs32YhQ43jqeertMGwQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=a9UyjXxhcxCnBEhIEsDoX6qCm95IQQC45HgJBPyoSY8=;
 b=eh01LGcJsx4XYqV5Q2MPMwhjOP36U1qRkGU+agX5aMLVC26MDYsj96U5KhDowTezd4uUA9aPiLUQDBkqglASpIz01/G/2DycYJzzwQJOXUIYpG0Zz++4pO5fvMjT4m2UiYiOLUVufpmW2IXZCA1BTtAV43YTPgHaQxjcRIiVsxaMnwdkMcqYjmoGjXNN/fCMKjc1qL9Bns3S5rEmwK8x2xqkJF3M791bKpqHbPpjSfFX9wyDt6YWnAkBiuhc/CGPFZhQsF1oTYvv/z5LguMxyw1BiECHo/b95cujDNew4FIz36BkGYppFSNVC1tkZ99YdC0iDR2pQOsauN65rnU0Iw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by AS2PR10MB7072.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:594::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8699.24; Fri, 2 May
 2025 08:29:15 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408%4]) with mapi id 15.20.8699.019; Fri, 2 May 2025
 08:29:15 +0000
Message-ID: <a8f99b04-2587-4d8d-ace9-a8b9b32122c6@siemens.com>
Date: Fri, 2 May 2025 10:29:14 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [ANNOUNCE] v4.4.302-cip97-rt54
To: Pavel Machek <pavel@denx.de>, cip-dev@lists.cip-project.org,
 Chris.Paterson2@renesas.com
References: <aAk12WeQsf2OeuZy@duo.ucw.cz>
Content-Language: en-US
From: Jan Kiszka <jan.kiszka@siemens.com>
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <aAk12WeQsf2OeuZy@duo.ucw.cz>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR3P281CA0119.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a3::19) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|AS2PR10MB7072:EE_
X-MS-Office365-Filtering-Correlation-Id: 2af3730f-17da-42e9-e737-08dd89536cb1
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?cHVCdExscndZMVBtM0JxdzQxYWVoVkNZS0xTT0tqQlpsOUg2eUI4SmlKN2Iv?=
 =?utf-8?B?cVR3cVBPL1EzamZhMW5UMHh0cDgwRkxMKzBlVXQ4ck53NExTZXhuQVZNNnZu?=
 =?utf-8?B?Tms3V1JES3BBSEgyNWVtSGV4RGlhZm1NaUNta3k1TFBJOUFMYjFkbGpOWDdV?=
 =?utf-8?B?N3JVeGFwQ010dGVTVzkzT2tUS1hER2h6dmlEL3dTSm9wUG85bmZtalpnYW9l?=
 =?utf-8?B?dHlVTHU1Mi9TSkVGSXcxcm9yS1luditzU1VSL1kvWTFXakREUlY4TmdqYW1z?=
 =?utf-8?B?M09HY2NjdVJWS0p2YW9iOFZoZ1B1SXA5UVpvbjhOMDlwWlQ5TEJNZW9BQk1z?=
 =?utf-8?B?UzBzUmtjSDVzQ3A3d2h0cUpiVjBsUDZ4YWl3L3k4MXphYVlVU2VXSGdvRjh4?=
 =?utf-8?B?TG1wSFA5WHp1WXp2eHVBdzdZQ0RPbEhCMXpTcGlnQUllOWd2RHdKNzZUTkEy?=
 =?utf-8?B?bERVYzR1KzFBL1ZjamNsY0FEUjgwdUVvRDVKeVdPRlplYklmOUt3TVRzd3U1?=
 =?utf-8?B?cUlUcUtBYnpoTWtERm5ubFQ4NmsyOFVmLzdDd1E4QUJYWU91SDdLRG1Fendm?=
 =?utf-8?B?cWNGRHpPRzBpdGRnaG1jT3NwRnlQYzZzcktHMFQvM2FxTTVnTUxrQ1JCLytH?=
 =?utf-8?B?OW5NL01wYzBZV1BHbmRuNFFzaXV6SjZFQkVGSEM5Qk9SUnR6ck81NlVjUXJj?=
 =?utf-8?B?Yk9wSTZBRUhmT09XMU9mSWVGbWQ5N1o4SWdCM2UwRGFsWEVzNTZBR0dpUUJO?=
 =?utf-8?B?ekpNMk8wSDMySjhJaUdxUHIrTGFiUE1YY3hMcVdxdmJzUDlzUnl3UDF2cTRD?=
 =?utf-8?B?UmtBMDhyNyt2N3lrUHB3dHNNT2tWRHM1emtGQ1NQdVBjdlByaUp2UWdUOTN1?=
 =?utf-8?B?VnY0b0NneTNIRThpUUFvNE00dDZjUWtFL2FyMUppT0hSN3dTa0Y4SGRFYTlW?=
 =?utf-8?B?aStLSzBpMVpmUjVXd2lwTitGUG8xbm5BSm1DN0tjMk5YcklGN3Q2RGlOcGpT?=
 =?utf-8?B?dTl2Z25kQ2tHeWVOTkFVVmI3NXBFM2FWRC9yWTV2KzVnc1BrcGtOL3dUOFln?=
 =?utf-8?B?c2dvYkIydTNsWjE1UTl3UzQ0WHZibnlPQ0ZkbjNvOXQ0VjA0V2ROQThZUG53?=
 =?utf-8?B?Q3lZNmJQOEpvck9lZFg4clczRUNxVklIRVZoMUpRMDBHOGJVR2JmYjZSNUZt?=
 =?utf-8?B?aEkxTElUZVU2SVNZRmJJOWhUdStNOXduZ2ZSSXhjQXNEbWVRKzNnNHJjeWRU?=
 =?utf-8?B?NmJDTXdPNCtPZ3Z3UFFzc0I5QnA5S3lUdTNnSi9UL1FFVFp6c3pqbFNjYnNs?=
 =?utf-8?B?ZVpnSVJ1a1lHSWo3cWR3dzVBL052VkczdHU0bEY5cVhpYnRURWo2RUdlc2Fa?=
 =?utf-8?B?ZjNKMjdRNi9LWVhVbm5sK3ZWaUgzREhzUGJmNjNRUXJhejdUZnVlWXJPSkZT?=
 =?utf-8?B?VEhvT2hOYWdFcm40SG1LdVBkTG9OZVNMZzhQNk45clRJMHVVWXFIOTQ1VUtq?=
 =?utf-8?B?WWorSG02Uk1lZ3VhTmNaTExkTldDYnF3b20yV3U0Z2xsUWJnUmVBaFY5VGZO?=
 =?utf-8?B?aFBsTkFWTEZYT0p4bm9wRkI5UkJNRGIrNVhiOWRFNm96Rnhud2pDcDZWdDFY?=
 =?utf-8?B?dWRqZWZIdlJyb1g5ZHA0MkNUcWxXL293UGs3VlpxK2tIVTJVdm5VbjdGaG9v?=
 =?utf-8?B?Tjdya0ltY0JlR1NGdjZmeHk0OEo0WHFtUFc2QnhuR2c5WVFOcjhHLzI2SzVo?=
 =?utf-8?B?RkRxVlJpM2VycEF1SGY0Z29NSDNhL0dLNGVxRmdHNm9HWldHbWQvUlJvQmZ6?=
 =?utf-8?B?L1lCcHB3YTIwVER6dWYyOW9HL3YwZWMvd2dTb2dRUWw3WktMTVRWY29YZWdI?=
 =?utf-8?B?WUJZN0pEWE0rMFIvc25EM2dVYzE2b2pvTFNhajhWNDNaNUVHcGlCam5kYVcx?=
 =?utf-8?Q?KBSjNKtp4Lc=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?bGdjR05ISTJ2aW5JNEdUVHBNdEtscGkxNno3bUVoKzZuS3lLRHJROVhXNE9q?=
 =?utf-8?B?a2hZU1Q2MTlUZko0L0tVMFFxTFdaeGdneXdpMkkwZjZadTR4NkNDSEo5dE80?=
 =?utf-8?B?RXNiWVl4SjUvYVJoSDlIMFc4VnpZNGViK0JhWXNHVnhhNmxKQjZUT0xaMzNB?=
 =?utf-8?B?WmFFS3E2N0k2OGFYY3F2VHRYUS8xYkZrMWhjL3hqR3U4eWVsdUhFeTdYSisy?=
 =?utf-8?B?L1U5Tlp2RGc1T3JlbmNNS05zUnp3ZjFTR3lHbWZFTXFBR1JMZ3pXUHRaYWpx?=
 =?utf-8?B?WXBrNGd4VzJqaU5rZXEzWlgvWGFiUzFCeVhEUm5kSmo0Z1dqdElRN1UxcDEw?=
 =?utf-8?B?SS9HTnFkWUNVUjdSY05GSCtOVDFlZEtURWMvWWtYNmVVM0FSRy9vTmhtdlpZ?=
 =?utf-8?B?Z0tONUd3YnBMay9OcXRHUHhBbDFFYUtiaTVQb21UY3V2d3RDN3diejZ1Y2hh?=
 =?utf-8?B?SUxMbmJGQStpRW96RjVYcm52Nzk5bUpIeEM0aC9KcTg4UFdBQnZyL3FpYTVr?=
 =?utf-8?B?Mno3UlJWTnBJaWNrUlhYbmtoeGcyZ0dYRXJ1TnVPdGEzYzJjd2RBWHYyakdJ?=
 =?utf-8?B?NjNWbTNieDR4dzZOYkhibGtkbFlrVnhUNDByQXRiMEFPT1JFU053Z0tzdUhi?=
 =?utf-8?B?TlY1Ympja0VmVVRDL0t5NHFNU1dyR0dTZjFVWkJ6NFhEMUZxRis2TWhNMTIz?=
 =?utf-8?B?R1NFQmZDQm9mL251dkgvRkVPY2szZUJtOFlKVXJoRFI1OVBrZWtYbTl3MHMy?=
 =?utf-8?B?U3h2ZnYwMUxwS2ZNRWpTQzdTOVVIbUw2M3RGOC9RT1NHbmlmQ01SQjE3azVX?=
 =?utf-8?B?SG9DVmphLzJ2MUtKMzBnQ1RsRi9CMG5XWmpyUkhrWjByeVlHOERacCt5cmpG?=
 =?utf-8?B?ZWFWUS9neWhOekJxVmJQOGNYL0YwUjVHVURnLzFTTUZIck93WUJYVFZadEdh?=
 =?utf-8?B?aitPWVM5UXdQTFZtdW9Ebk11TE45KzcvK24rSkNlZ2loYVdSSFQxcExkcG8w?=
 =?utf-8?B?dTZiZ1hDQmRUNDIvT0NyNmlIemNFQWRPQzc5NFAwa3h0SGUrVGo0dTQwdUZn?=
 =?utf-8?B?cEo4VkQ3WTZoMGVScE1UTCtrcnBOTGxFM0N3NlFqWHJsOUs5MVpiZjZESjZG?=
 =?utf-8?B?cHVua3MxNkdZZWF1S1RJMkYwejBSU3VTZVo5QjM2ai9JNHAzdThxU1dNdVk0?=
 =?utf-8?B?ZlpHa09SWHBmaU51eTRsOFlWdkZNYlJmL0pzRWplVjhQR1A4ZWtrdTFMYkRo?=
 =?utf-8?B?ajgyQnRuWEpzMHR3Y25lZm1DSTlZd1JlbklBWFVnR2MzWFFRQ1g1VFZ3UDkw?=
 =?utf-8?B?S0djaElsVUdJbTRrUEhOWVF0S2dhVEg4SHVvYXpZZUh3TlVBZVhtU1drMDVF?=
 =?utf-8?B?YnovWlBJakJGc0thRVJpTitITmpSZFRHek9wYk1jd3ZJcWRiNDkvTmNVZnpO?=
 =?utf-8?B?RktNcmtuL2tnbVdUd2JSdUhXUjlueTZzc2pTL2ZHUnFqdGwvdVRueDVhTlMx?=
 =?utf-8?B?UFNCV2lncTljeC9CL3dJbHo3cUxqZUpTQ2tjM0ZUYVdFZWkwOU9lNzVwS0NW?=
 =?utf-8?B?L3lBT3dlOGt3MXNZVWtWcFFKeUsvVW9wamF1R3R2UmdYTk5tYWhaS1dGTGRI?=
 =?utf-8?B?YUFVQ0Q2NWRtaS9kcmdpc3k2S0NxUFRTM0dGVitrVFVNVTAxVHhoNmVRYnpX?=
 =?utf-8?B?bTRXZzFZdWtPbmZLQmhkcDd4M2xkV2pmRFR0bUdyM2Vycnc5ZE1Ud1RXUEcr?=
 =?utf-8?B?V20vY1BXRFJhd1JNR2x0dUlGaVBnUzVabnR2dWlpUWNmQ21xMXA2OHdweEZS?=
 =?utf-8?B?SFJSQWxkd2VtTTRXUTZOLzc0a29EbE52RmJoWU5lTnpaVy9CZUs4RW5wV2Fn?=
 =?utf-8?B?ekdPblcwTlR1Y1E2R3FJYXkyUTVHMXNIUGFBcEgyRnQraW4rZDlaNUsremFn?=
 =?utf-8?B?UUlQTFdTUzZNd2xjMEZ4N0svM1ZRQTVBZWtZY1JnUnNvZkpKSEpKQlpvdFAw?=
 =?utf-8?B?czdyOUhkRVRIS21SNEYrOExCUWk1UUdrcGpvYVBpMkE1RjhrcFViTmUwbXox?=
 =?utf-8?B?YzV3NEt6bUkrVzVUSjBXd3BPL1JkUW1EVklsbE9rY0JCaVJERkRaZjFjRFZm?=
 =?utf-8?Q?QhcfgUcdxCNj8A02qsvaGuEKJ?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2af3730f-17da-42e9-e737-08dd89536cb1
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 May 2025 08:29:15.6985
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mymx7oi5O2tCkNBi59JHL00mB3KRKYZVtWBKiJRJZn/VrEGo2OpI01uvYY35y4RMxtoISXgpBE07Vv9IALylHQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS2PR10MB7072
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 02 May 2025 08:29:27 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/18754

On 23.04.25 20:47, Pavel Machek wrote:
> Hi!
> 
> New realtime trees should be available at kernel.org.
> 
> Trees are available at
> 
> https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.git/log/?h=linux-4.4.y-cip-rt
> https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.git/log/?h=linux-4.4.y-cip-rt-rebase
> 
> This does not yet have fixes for "Repeated WARNINGs in
> unpin_current_cpu()". I'll work on those next.

I suppose this update will also lift the baseline to the recent 4.4
release, right? I only now realized that this was using the 4.4-cip
version from March, rather than recent cip98. Why?

Jan

-- 
Siemens AG, Foundational Technologies
Linux Expert Center

