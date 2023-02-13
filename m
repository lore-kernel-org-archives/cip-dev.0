Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 874E5C636CC
	for <webhook@archiver.kernel.org>; Mon, 13 Feb 2023 14:52:08 +0000 (UTC)
Received: from EUR03-DBA-obe.outbound.protection.outlook.com (EUR03-DBA-obe.outbound.protection.outlook.com [40.107.104.51])
 by mx.groups.io with SMTP id smtpd.web11.16223.1676299922057916949
 for <cip-dev@lists.cip-project.org>;
 Mon, 13 Feb 2023 06:52:02 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=uk6HUedI;
 spf=pass (domain: siemens.com, ip: 40.107.104.51, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VxoUszfV5j3nZy/DiBvQJFvjXc/pWaaVxTl6ES73qjN4avVGhm9vyDW5WHccBE9QMtrbvumOrBAdPCJAnbDN6J2sxV85S9W7u7cjwBEUuOAKtQyeQCHLh/X3Be0bz01/pUTWAOKxaI6h8HGHL5fyclxornCXDwdXPPUgimJ7uOPHBO9b+E2SQEBk8HvKz+J8LS8vIXTuvbh/SPwX+ZEhDuGxcOrtCuHe/VR/aBoAqyuVeRNp8kuhJM4uvrZA2mZnjTQpai4bT41Qb52gV5Yh/reO6J2IFi6nm2IQdmvtCpMK/L2oFiKcfFLTMJN8vzpT3YDWHszKCy8lKw9r2OUj2A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eL4KVK1AUy1+Ex8HioAWptO0BOiSVIr4SPmuEmlibkw=;
 b=JqleVcTl98sCR+YXjtmBIj+5tZRvKfGmsHPJ7SD7hdU2Q9wstSp7z3gvBggGSg7PLJDnckHV3ZYwRJ1iwUThDBAi0hXXvjrvbdbxFhI7aytwC7q1duzuqGF8OQOnTshTjNrd/w6rUwe3OxreUCdI0CKUFn0kNuoYkcX5cvkywFOmeDAR72GGyoXGf4M7cv+wVTQ6a90RE+Yi5lclYdFjVHHLMP6hs+RGbPh951rFmlrVnAcHUzhtD/j9nHn1ld3hPFRn9p0leu244XgBqUUHzXltI/+PuOsF33FQ1HjrcH3twI5CSv+bu6gb0T3BwbLheBqnr/0KYv+Oy7NHbXeBYw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eL4KVK1AUy1+Ex8HioAWptO0BOiSVIr4SPmuEmlibkw=;
 b=uk6HUedI/uss/vXZP/r6Ilgpnz9+oeXDuF9HEcZ59/4lctWNjxQNTEdi255EnBTwr1I7ng2S9ciYgpEjSf5/fIuEGe2fyNcEJ60jY7NrbbIddeKHgMOJUjZ+ZvG2iY4NNjiy/yJ3fzy5EdCWoru3JIqCuT1wcLRZtvVCPv/ZKa2Qjqd8uqPQt0D+TpaTXh82B7WtdX9GG0BpVQNTI7LYhLORF/5d5qXEaUNMrDr4OLi63c5W+QE/wFtneHTUhy0gOXZC2shPBYu6i+k/YcwCKUp9Jb0pi5ttugDYyZst302kIvxBUOGY9v3ijJGVZTMcocUqat8ffSm/CdH32mVNgg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by GV1PR10MB5915.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:150:5a::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6086.23; Mon, 13 Feb
 2023 14:51:59 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::784b:e95b:b855:dcc5]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::784b:e95b:b855:dcc5%9]) with mapi id 15.20.6086.023; Mon, 13 Feb 2023
 14:51:59 +0000
Message-ID: <7201431e-f281-8a48-dceb-5419673fca3a@siemens.com>
Date: Mon, 13 Feb 2023 15:51:55 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [isar-cip-core][PATCH v4 1/8] register image classes via
 layer.conf
Content-Language: en-US
To: Felix Moessbauer <felix.moessbauer@siemens.com>,
 cip-dev@lists.cip-project.org
Cc: adriaan.schmidt@siemens.com, quirin.gylstorff@siemens.com
References: <20230212082758.1166262-1-felix.moessbauer@siemens.com>
 <20230212082758.1166262-2-felix.moessbauer@siemens.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
In-Reply-To: <20230212082758.1166262-2-felix.moessbauer@siemens.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR3P281CA0070.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:4b::22) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|GV1PR10MB5915:EE_
X-MS-Office365-Filtering-Correlation-Id: 7caf3684-dfe1-46ef-082d-08db0dd1dba5
X-LD-Processed: 38ae3bcd-9579-4fd4-adda-b42e1495d55a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	5aevNVAj6qT+b+kOtMgy+nGNG4znDjrhphiCEAxRxcchemxAioil/JEWuQFPGtOMXapJJkJufIeTJDRJE1QkZUdVNKswVRQgGi7EpbXjPPHVl2HuWY84HNKSfTOShXrsf+LijGYuDMOomDg0MbyWbiC0VfT3rPeeXcwTF39smA+GsugyB1mysJ257AL0nDZQrzCC/WP3o+/cUJ+dzAtNPXkeEcGbuDRmNEvitdLMctbKCgpVmQrbmfvapMOTxSC9QXzkNP4t+fqcd441MgbTAFr8bf4pYGg91OMg8oj2mseIkfmYZ3dazzjSQxWA5U606FYqStNVMJjcpwPbSPB/h0MkyGxykNGFGUyQoLzEbYECukEc4mNlCF02t/3hR9TURrvSYrvDFcISyc2SXONRSnDS3j1XJ/2w5nQVUGAmFxTotZQpOXj42ex8C62aEBfVkvUP9FKuB1x+NX/mWxwD3wBIZfOOVTwL06tPTWbvMlqT70pqkD41NGXeHA5uSLJO437f+fCdMZW5intYVHojeluyfcPZLs56/a4LCs+9p//Zz6LaxATzfvauwesxBZAZtGw6HANtvpRpWTfqUTQpmKNR2r4oEgOzrXxBQiHsJTnnz8t34ZwBJ01mxnzDTC9yOYxg/dQmnD6blCyuzhC9gILqjShejWly/UhUT5lclaaMi0vNCrdXzRqt1JZ5hjtvLB7TeUVaoyKLyazP0Xkz28bYn6XFP4MUIPl6sZCs+unASoE2KzlOf0BJad1Vy5KT1GG1nupdQrPBP5TCM7Uer+nFIzXF13BFiKxWWJjGZFI=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230025)(4636009)(376002)(136003)(396003)(39860400002)(346002)(366004)(451199018)(107886003)(6666004)(2616005)(53546011)(83380400001)(6506007)(478600001)(6486002)(82960400001)(6512007)(26005)(186003)(31686004)(86362001)(31696002)(38100700002)(2906002)(8936002)(5660300002)(4744005)(316002)(44832011)(8676002)(36756003)(4326008)(41300700001)(66946007)(66476007)(66556008)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?QkR0S01Bd3ZZWWdYZzFBU0tuUFB2M0tHbFlUTzM1OC8xcklmd3NBRnJBbGNP?=
 =?utf-8?B?bHM4aVdVYndJR2JLQ0FIb1ZBSWxkRzlVUDRLZFQrSjdZMnl5SXgzd2hENzZY?=
 =?utf-8?B?RnhwVFZyUUwwcUlvd095UDlncVdEdHMvblBJQU9PRkhoTnRaWThzVGZsMzJx?=
 =?utf-8?B?bXh5MEFLei9UNFh3U0d6ZyttR0VMMDl2UmI4bGtSMHp5bnlTRmhZZUJOUC9n?=
 =?utf-8?B?azlyU1JhYVpNalVmUEhHUUlMaSsyMGlIbW9mYjQ5N1FYcWJVMlNXQ0w5c3Jp?=
 =?utf-8?B?M2V5d3VCN1lqTFhNL2NQcXMvcjJYTEhrRWdKLzZpWGhCMmI0QmkxcmhIajdN?=
 =?utf-8?B?Z2JLblN3aEVyYzY0N0xQZU4rTjVEQllROEhOa0h0Qi9qdFBkNFFZLzhjbHdw?=
 =?utf-8?B?allFT1A1TGxOZ0kyKzc2TXBBb0MvTUFqSS9LMW5SdUhGRG1xWmM4dWx6akYr?=
 =?utf-8?B?dEI1V1RSUXlsajJlQ1V5UzBIcU05UFFrTEtISHN5UEJrNjB3NHhtSW95aEw4?=
 =?utf-8?B?R0RGYXRqVjRwNGw3akw1dFdlQ25FdlE5NHhlRGdEcHQxc25VeDZ0VGxvem1Z?=
 =?utf-8?B?bEZGSjZMV3dyd1lmczJoQVVzeFlyM0kwaU9hcCtjOWU5VndWMCtwYUd4S1RP?=
 =?utf-8?B?WU5vT0Q1YllRbW40clRIbkd1ZVhNU3NmRkxzSGp4VW1wQzhrOGRCL2lpTG0z?=
 =?utf-8?B?NFJVT1kwOTd1RmlVSEFpbkFpMUxMVmh2YXEwZnRGT21pdW9iZTA4d01Da2NJ?=
 =?utf-8?B?bVE5bVZLL09JOVRKN2psWC91Q3dOS0FrakZjUDhXeW8vam85cjllUEZab1Yz?=
 =?utf-8?B?d0cxdHhpRnFVbDZ4ei9TcGx5VzFZcVFQL3A0QktWOGxpZUI5L1AwUzJ4c2pI?=
 =?utf-8?B?N0d5ckpYZnJ0WUxHdkxlTEkrMVl1ck5Ec1ZKbCt4RnFiWktlYnBsejRtYWxT?=
 =?utf-8?B?RmJJY1NSVTdzMFkrOVVWOFNOT1pSMWNWUE1ZQzlldzBrU0l6NVRSaTduNnpJ?=
 =?utf-8?B?b0RhZ0RoM0s4L1VWOEp0UEZSTDlVSy9CV2NDZW8zQkNyblpRNmg2QldpcElk?=
 =?utf-8?B?RGVKRk5yNjBScVRqSWEySHlXZU5YQzVMZW9sUVpiQ0RMbjR5SkFXZ083UjA1?=
 =?utf-8?B?UGZySG12QTB0ZW1IQkNaWDdrRytuM1BJUXNrYWl6NklUM2JIejk0bkFQSkZ2?=
 =?utf-8?B?bGRyU3VBWlJGRGx0dHRoOXJsNHNwTzRWZlp3N2ZzMWxnWGliTk82a09NV01i?=
 =?utf-8?B?MXpKdmp2dEJrZFE5bmtlV0ZhRGV5QUlMV040UGxMRlNQaU1DUlpGMnNlMXVT?=
 =?utf-8?B?OE5xWVc1NEh0bXg4bHhpc2h1NkZ4Y05tdk1NYmFhZkx4enVqbzdHc25aU3FE?=
 =?utf-8?B?N2NVSzlHWHdvelVTWERZNitFSDNaTXFlUHprQndUVE5lSStDckhnV0dxcTNJ?=
 =?utf-8?B?UlpHSjFRUG1SWlhZTVl5cldSZEh4Nzc3ZjcwbTdva3dhcVJwc0VVRk1sOWdB?=
 =?utf-8?B?QUtVa0wzL3hXK0Q0ZEYrVURLcUs4dFZ3UkluZnplN1NkNFZrbHF3cHoxTTBq?=
 =?utf-8?B?ZFRKcHJUSm5VaXhDQ1FzT2JlWERXNkdFRWs2MStKbllETG9lSGZKYkhDbDFQ?=
 =?utf-8?B?VmgvOGRMNElKK0l0ZGx5VDV1dTRzekJGRXNNYTVscmc4d05JbEVPNHhkL2FG?=
 =?utf-8?B?WXNoNDQ4V3NCVEROTU1JaXVMQ3M1UFI2eGJxL2hyYm5pV3ZaSHRjSGw1UGNm?=
 =?utf-8?B?cGQ5REtSTkJodTVPV0pPek95RFc3OWpqNnpSa01HU2hzMlB6NVdhZFZWZDRV?=
 =?utf-8?B?MGZMQVpvWDlvN2J4VnJ4RWNqcExQY0ZNR25VVFE3TGxLZTZTL0xKSmZxN3Zq?=
 =?utf-8?B?ekd6RmIzb2k2V0c0RTh6bks5c1FwcE51bzNBVlVjK255R1JPV2ZubkJJeTVs?=
 =?utf-8?B?Yi8vWW1jMlVxWWFBelhIZVdWbU5mTXp6VnhtaUZZbktBR3YzNjFZcUczT1ps?=
 =?utf-8?B?NkRXU2dkc1FISFdHYWMvYmlTd2NkVnU1S0ExWDBjcUlqcWhvSU9OQ2hIVXFI?=
 =?utf-8?B?cW41aHh3MmY1ZlNNYnNJdWF3Y29TNDVZbk92bnFocW8zMWJ5cWJSZzg3aFBq?=
 =?utf-8?B?cmlqRERKbXpKeGRDT2ZsbGhmS3RaMVVwdHM3b1ZOY2VnZ1JwQmlTUjh0MzUw?=
 =?utf-8?B?NkE9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7caf3684-dfe1-46ef-082d-08db0dd1dba5
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Feb 2023 14:51:58.8658
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +PJuJJAJIBpOmjcZOt26nMyoNZ/VgHotO+csjsEideTA+2LENJx2bMhCho/Jlt1sQHGwZlJUsYbyZhl2YAEYyw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR10MB5915
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 13 Feb 2023 14:52:08 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/10682

On 12.02.23 09:27, Felix Moessbauer wrote:
> This patch registers the provided image classes via the bblayer.conf
> file. By that, no manual additions of these classes via kas is required
> and erronous implementations are detected early (e.g. mandatory inputs
> without defaults).
> 

Then why is this commit not removing those obsolete IMAGE_CLASSES additions?

Jan

> Signed-off-by: Felix Moessbauer <felix.moessbauer@siemens.com>
> ---
>  conf/layer.conf | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/conf/layer.conf b/conf/layer.conf
> index 0c5fd39..2c888b2 100644
> --- a/conf/layer.conf
> +++ b/conf/layer.conf
> @@ -22,3 +22,5 @@ LAYERSERIES_COMPAT_cip-core = "next"
>  
>  LAYERDIR_cip-core = "${LAYERDIR}"
>  LAYERDIR_cip-core[vardepvalue] = "isar-cip-core"
> +
> +IMAGE_CLASSES += "squashfs verity swupdate"

-- 
Siemens AG, Technology
Competence Center Embedded Linux


