Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1EE9BC25B10
	for <webhook@archiver.kernel.org>; Fri, 10 May 2024 11:37:13 +0000 (UTC)
Received: from EUR01-DB5-obe.outbound.protection.outlook.com (EUR01-DB5-obe.outbound.protection.outlook.com [40.107.15.88])
 by mx.groups.io with SMTP id smtpd.web10.10555.1715341027183804681
 for <cip-dev@lists.cip-project.org>;
 Fri, 10 May 2024 04:37:07 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=F1l/74K0;
 spf=pass (domain: siemens.com, ip: 40.107.15.88, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NLXqoEMYm7xLL6kwnN/GB0ww0SeVPUVkywg3rx8cj4nvuY3UrieNwvlpA5tI6f2ZNYyZW5I2zEA58CtNmZcoTkwWY2HyWIecHh7L6JhLLHmFbq1BmwhfyHX6b0ZDMtPQFl9Qfv2UNNshir3+/mBX96o7+s/dpk5+wL2IxUZ+iwU/NjcEmzOpkW4cbyYgw0x/AD1R6Lc+6XS76uo0lbjyjvXPYX4KKkh1geOAtRXbJaetwNdNooRgu1gJAqsQNr8Lto489ajq+lqoEvMkvNaXFKd2+f6x9JH2spD32m6oN+SKiO0LNt2CJ6OZd3AU5TP/o0X6k9oG6W87Kq8NTTPf6g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FybCja1B+4uu7if7Y8sYLI/axNjBCEU/bsv9T71Ky+U=;
 b=ah1964HqDAzbSRtznND3MJkOOHFW+iDn7KSrI8PHEtDi5ro4niP8VbSSfrK4nehnfJw8L/MnOvbc5C2+7nLOQn4N3SjeoZGKuR+6UO+FS04KFZDB1X6xT1wjp1npOt4BDq0Vsx13b2hpuhdxKJaGXbwYmquEvYBkClkv9HgkQFkuF8MWc3VFQgiwNbdIhEdRg3KX75fIUrvVr0ojXaIdqn1Z0lwQ2IcnNorCdYIz8SWVh7egCwwIkE+9JmCX+q2v4W3/86oXBe9D0iPhl3OgbHm1ApClHMRFyW9QeZwKO8AxU2+c+enWvM5rg0m0kzXm+3ueD1exmcRxXoEwqgExag==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FybCja1B+4uu7if7Y8sYLI/axNjBCEU/bsv9T71Ky+U=;
 b=F1l/74K0JIF+ZjpG3kDEBw+naP8G1EyUKHFV1xtZTx8AJpyz5XO+pA2KdDE4uJthpjsVHtEvALiUxreKHa10RkvVYV2hObBDt4gvP8J6ALN4xx1AQCvAyMK6LV9MG1lBGsGEVCJ0DUhIjZP9nOms+W28pc1sbQ6VbhdEJXtrZ7kWVZh4pP4C8DpuqVjQOmPPAVRKIJVA3FBSBCB/hbqTMh3mvCkee8BZRvSp1Pljkk/h5oJFJcyqZNlyTddAVbv5ZXj/15kQXanmtJNhrx9svBiB/DCRkVBwmwYb57rFdzXYtFD8Z0cRXLpLOd1qzrDzFjQBT7rDm2yLfZEC7fpJ8Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by AS1PR10MB5144.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:4aa::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.47; Fri, 10 May
 2024 11:37:04 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408%7]) with mapi id 15.20.7544.048; Fri, 10 May 2024
 11:37:04 +0000
Message-ID: <1e9914af-f21f-4bf0-b30a-89c058b61395@siemens.com>
Date: Fri, 10 May 2024 13:37:01 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [isar-cip-core][PATCH v6 0/4] Integrate Delta Update with
 rdiff_image and delta handler
To: Adithya Balakumar <Adithya.Balakumar@toshiba-tsip.com>,
 cip-dev@lists.cip-project.org
Cc: quirin.gylstorff@siemens.com, felix.moessbauer@siemens.com,
 shivanand.kunijadar@toshiba-tsip.com, sai.sathujoda@toshiba-tsip.com,
 dinesh.kumar@toshiba-tsip.com, kazuhiro3.hayashi@toshiba.co.jp
References: <20240507091432.895626-1-Adithya.Balakumar@toshiba-tsip.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Content-Language: en-US
In-Reply-To: <20240507091432.895626-1-Adithya.Balakumar@toshiba-tsip.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0368.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:f8::15) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|AS1PR10MB5144:EE_
X-MS-Office365-Filtering-Correlation-Id: a36e5dba-2931-4058-212d-08dc70e583b0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|376005|366007|1800799015;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?T1NaRVZURHlScUxWZ3dLUUIraVVLNUpzcWJubG9GeERtbjByS1NLbVZHaWs4?=
 =?utf-8?B?T3RidEl4eDBnZkxjSk52S25QSUxrTndNdG5IdmVDSGtUZCsxa0FETUEvaTlU?=
 =?utf-8?B?TGNxMXFSdU42aW5aaU9YenZFNFRWcndNNi9CZjI2ZnA2NzllS3FTbTU2VGNp?=
 =?utf-8?B?STRJdUJ5bjg2eEhDSzkyNXpWd3JoazdFcnJiZEdGclRWRmlyWWVUK0tCRU9i?=
 =?utf-8?B?RjhWVStwbkhaWmhSRDZ1MWhKR1ZQeFd6UUtySVEwZUNBWFhaZEtORUczRmVq?=
 =?utf-8?B?V1dFQjlpaUIyRzZURklYUFRVQzlFWW9KYUdrLzVwQi9wTE5VbDc4Q0gxTEFG?=
 =?utf-8?B?WDdwK1ZUU1pqSXBoZHV6d29WdjdSVlFodGJGVjRNYm14TFIvRDJ4SFRxWXVl?=
 =?utf-8?B?TTF2WEFaQTBFUUdEc0N4bmhOTmNSRU5XRkFsR25wZ0RnZ1ZpSk5OUXdUNWJh?=
 =?utf-8?B?elVlWUM4bWtrVjdHQmRSeTRiNWVKZWdGYzNjVzNKaVl2TnYrNUcxZFl5UGZy?=
 =?utf-8?B?R1VNd0hMT3k3TEVIWHlubHEvcGhTN3NhRHhoQ3p6cGpuOFhMUU5tYzNLNHV5?=
 =?utf-8?B?ZmM3dXljczdncVBWOG5hNmVneGw3YWtxekxuNlZpbmdwYVVTL0JvYmVLRWk0?=
 =?utf-8?B?OEluSDBsRWZZU3o2dVNVVVgvQjZmSndCZThDaU5heXVUSXA0Y3M2dXlOaUJ1?=
 =?utf-8?B?S25yZStkbERUMFNIemM3UGZCamlTYjFiUXR3bmpudzJhZlpmUjZFODlpOURI?=
 =?utf-8?B?SGlqOEdBd0dSVUI5RkVkcWZWdDI1NDM2RFhTMWdvZUNMU3RkMWJUOXNoUk9t?=
 =?utf-8?B?ZVloR3N1WFBtU1VDaGFvM1ZZUVBkNjBKeHV0ZE83RHcwOVpPYjl3c1MwVEgw?=
 =?utf-8?B?NmxZTkpoVFJDZWpWZmYzMXk2aEVzVTNWNlhGTzJURmJFRDdHa29vdjN2ODhN?=
 =?utf-8?B?Z0wzUG91R3ViaFVJVC9hTXNWeVYvYWpzeUpnbjNwUmhIalV3S0phclEvVU8y?=
 =?utf-8?B?NkxUWlRHZ0tmY3d2MzJDa2YyY2ZSVUZUdXF2Vk04RlZpbm44T2F4QmwwY2Qy?=
 =?utf-8?B?QzlRYjA2MTFLZk5GVjB2OUppUXA2MC9JUVlRbUd6b2pESmZvYnYrQS9sTmFo?=
 =?utf-8?B?SndiZ3ZBSHpEQTVnVUlpQ05aVU4wRTRyUDJqa2J3aFhNb3NPUWpIaTQ3SWhK?=
 =?utf-8?B?V2VIRUhOb3cvOU5DK1hJdGExYzFycnpvOE81OElIZnJiOENXMWFiTWEwMWor?=
 =?utf-8?B?NDY2aHhxYXlubmlVMG9sVTdVQWpBek55Tk5HS0IrR0pla0gvQ3BoU1I0aDB2?=
 =?utf-8?B?cVMrUXFsdEVxWXRoUXFQRmIraEthSjg4S1dxaWtwZVkvSHBuZnYzaUtMZzY1?=
 =?utf-8?B?aTk0clhwRDVjTTNYNFZVUHErZ3JRb2Jka1plS1YvL09lWXRnNTRjLzZwVjhX?=
 =?utf-8?B?U2pGVjU2S2d3c1lLZ3c4MTlsbTlycVY4MnNiM1NQaWFQekd1OE8rWVkzZklB?=
 =?utf-8?B?b0RtZVo4MnlDWGZPbE9ETE5ZK08wQlErMWhib2J3MC9BeHdGQVhUWmp4K0tD?=
 =?utf-8?B?SjlGaHlZS2hGakZnRlZZOUpLSnNvK24yYzRMbnVEaW40c0paZVNXaThPdTg3?=
 =?utf-8?B?SUZNSDRtd1ZtUmdlSW5VNTZQTHN3bjJBVTJBcWYxMVU3Q2p0bklSQ0hRbGtP?=
 =?utf-8?B?NXRvRkk5K21QNk9obTk3SVNxVkJIa2pBV0xlYUFjczFBUDFWcjJRRXpBPT0=?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(376005)(366007)(1800799015);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?amJycUdpSTU0UVhpeTFIQnRyU2lkYnVUWmY4R00zb3A2MzdVSnBhTGxyYVpv?=
 =?utf-8?B?eVVWcWdDa3JHNXc0L2tTeVVIcXluS3pvK0EvVC9weVVBT2dVeWhjRmFZRjhl?=
 =?utf-8?B?OFMxMTE5eEpFUDBIQ0VvcHozQXJlOEJtck9zVUpTeklpRkM0WlM2NENSaUli?=
 =?utf-8?B?dFpZRXdJNGk4aVlOOUVEa0E3dHdQK0ljVEVtRUMrQ3NpNHVMK0ZpU3NPY0Fp?=
 =?utf-8?B?cjRCSFlnUjFEemcxQkc4eERBeE9oZVlzUUNmcnhKUCs0bXozdXhwN0hMeTQr?=
 =?utf-8?B?V3AzZ05kVVFxS2tQOWdSNmRYdlBJNHkrb254UkNRZGN0MDY3eTZ6N2VHSEtX?=
 =?utf-8?B?b3c2SG51ZEtYTlQ2U0ZWUGg2b0FmdWFpT0pSczBzL2VUN2hxL2NYZ043eHRM?=
 =?utf-8?B?V3FzU0h0YlNTNDdOQUZuMGdwNUF6Sm9QYzl0MmRXd0dZS3Z6ZERaZWpqSDJJ?=
 =?utf-8?B?MURCa3AyaGJzNVozeUp6c2JGN0JSd29OK2ZSUk1QQUI4WjRML1dtbWdUa0ZH?=
 =?utf-8?B?TGJaR3RqUW9SdVJ3ckNNemJMVUxabXA1aW03ZlozZm9ibEJoUjBtTkk3RTRP?=
 =?utf-8?B?SUl0eUY2T2xneDVKZUlNU20zK3I4YjQ0MjJkU0F2ZVgrcVYyKzJ3S0taLzFi?=
 =?utf-8?B?V3ZSaG5sV29hTlFmSDhvTHFXUHNmRnEyNlY2MHpPTjFHUEwxOGtDRFltS0Nv?=
 =?utf-8?B?ZG5uRFBhRHdrQ2hGWGhGbXgyK05lcGJYTW0yWXVMYW81RWhtK1RjVnlXanMy?=
 =?utf-8?B?ZEhSUnM5ZTFPd0NBU0l3dUx3UXpLRzN5Ry9Mc3R0YXI0RGxQa3lGQnRZeWVM?=
 =?utf-8?B?RFZmeVZVMnM3TnVueE9seTc0UE82dXlOOWIvS1FEZFlBUGxLb1VCR25sWE5U?=
 =?utf-8?B?c2NSQlhjaEhnRjdQT1RjanFzVHU5OE43UDhSMnRGUjdYV3M0dXJPWjR6bmxl?=
 =?utf-8?B?OExGTHQ3MlV6Sjh1QWpWWHNzaEJFd2dSemNVbm4ranNsLzFXU1RpcXdqakdL?=
 =?utf-8?B?QkppSzB0RThaSndCMVZBWlZ4bXhDNUpOb2NJbXhYQU8xdnFBUTRYU3hzZzFp?=
 =?utf-8?B?MVhCcHcwQzZJL0RuS3N6YmkrZEI4dUgzNmZjZlhpREZvOCtlOWJpc1AxTEw4?=
 =?utf-8?B?cXRzN1JUcEdOWmRMUkdiUU1mRnRBLytLbnFuK3lmbkNuRWxrZXZHVmZPMXg3?=
 =?utf-8?B?andsYjlPQ1d2WWJvbEVpWkpsSkxYeTVDdWh3eUZoS1ZNOUZnVFpYZTl6bmNp?=
 =?utf-8?B?SDBGM3krRCtSQWJzMGtXR3psWlBBblpyZVlvd0s3a20rMGF6aHJuaWhRS21Q?=
 =?utf-8?B?c1JiVGlhb3RZUmkyT1hobGxQZEpTU0c3Rmx5K09VaU1xeHdJcUVXVzNMMytB?=
 =?utf-8?B?eDFJZ1VNcTRtL0hNUytIeVhDUVh1TmxuTlhSeEo4R2k0RDFtajcwSVptWUg3?=
 =?utf-8?B?SlZ1QXlOL283ejhONXdRbUkveDFVVFFJTmNXZFMwbkxtbDliL1hVMmc2V2Fo?=
 =?utf-8?B?eWhuNXZqUkN0V21PcitHTzRrWGNyWjE4d2RhRmdWQ3c1eFIvd2ZIRjFwZDlL?=
 =?utf-8?B?dkE2dTFDeHhKd1NyY2Eyay9MS1ZVMUxGclkzdzQ4R1A2OVZ2M1drQ21OVFZV?=
 =?utf-8?B?Yk9qTWNzVjZaZ0R3bkFIYXRKdjcyMGxmbUtkWlhNZUtUZWR1cWduRVlMSXlp?=
 =?utf-8?B?VlVXdi9uSFlsMFFYaHlGTjVuRGNJTWNNdk8zT0JVaTQ5bzhxUjluVnFkWG5Z?=
 =?utf-8?B?ZjNOWWlNSkZjWExnWVNCOW1Tcm5HQTRMV256MTZmUmxoclVyQkQ3Ym42cURH?=
 =?utf-8?B?NnllNm9yd3VwSjkvT1NaOUY0UkdidXZTbzRzS0piejMrQ0Q4M0VqQjFjZElI?=
 =?utf-8?B?dkxOQ2R1OXlZTEJRRGF1MnlaWjROdVN2Vks1UXJrS1EzSm1HQnZvY0R4ZUFh?=
 =?utf-8?B?NzJta1htZXN1SVh0cTRMOC80V3pnQS9QOHhKcEJlN1g0dS9mTm1ldmRieUFN?=
 =?utf-8?B?bkJyNjBVNlE3cVRJR25oZG1HZGtNdnFsaFBrdm0vRGRVckYyTno3TS9KYkQ1?=
 =?utf-8?B?VTVKL1lReWp0RDZIc1Z6WmJ5V3F6QjZaSDlJTlczY2NqZG0yRmdFSm1ZQnNh?=
 =?utf-8?B?YVZ3d05xMmVtdHdNeHVmR2tYa2FkcmRydzlnQ1pSM0h1cXBiSmN0d01Sc1A5?=
 =?utf-8?B?MVE9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a36e5dba-2931-4058-212d-08dc70e583b0
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 May 2024 11:37:04.0166
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nZfxIG5xgkh9apfhvQsLer5JptmrGkcJEIwP2/1SSducvXkiSik6WjSbNlxs9nc7K13V5fhmXskr4HozRoiqGg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS1PR10MB5144
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 10 May 2024 11:37:13 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/15876

On 07.05.24 11:14, Adithya Balakumar wrote:
> These series of patches enable the support for delta update for the root file system with swupdate's
> rdiff_image and delta handler(zchunk).
> 
> A couple notes about the implementation:
> - In this patchset, Delta update is only supported for the root file system.
> - The newly added delta-update.bbclass handles the creation of the delta update artifacts.
> - The update handler type i.e rdiff_image or delta handler is set in the variable "DELTA_UPDATE_TYPE"
> in the delta-update.yml file along with some variables required for each handler.
> - The creation of delta artifact for the rdiff_image handler requires a reference image (against which
> the delta is computed). Currently the reference artifact file (.squashfs/.verity) is passed to the
> build system by placing the artifact in the path "${TOPDIR}/previous-image" and setting the name of the
> artifact in the variable DELTA_RDIFF_REF_IMAGE in the delta-update.yml file.
> - zchunk based delta update is only supported for sid onwards.
> 

Just wondered if we shouldn't convert our current v2 tests in CI
(build_swu_v2: enable) to rdiff delta update. Any blockers for that?

Jan

-- 
Siemens AG, Technology
Linux Expert Center


