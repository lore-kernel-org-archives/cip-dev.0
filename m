Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85052C27C44
	for <webhook@archiver.kernel.org>; Fri, 31 May 2024 06:24:33 +0000 (UTC)
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (EUR05-AM6-obe.outbound.protection.outlook.com [40.107.22.78])
 by mx.groups.io with SMTP id smtpd.web10.5413.1717136669078293222
 for <cip-dev@lists.cip-project.org>;
 Thu, 30 May 2024 23:24:29 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=edO+tAkP;
 spf=pass (domain: siemens.com, ip: 40.107.22.78, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Jj4VZMwb+bfODx2OQC/LlhCIfAL7gxp9JgT2WHsHs1FAC6AVOG9ShJzPagF1vJ5gWjGy2EeaC0yxuyFN0/ri0MgYwy1eraCMV/YNcdkLfJsDV26MaAhTkqoy5r/emZS8+YMxLqCIeZ9c5wISPzqHHspJ9VLiIoPt5hIpG0P+uPQUofah3wzGMmI74U44ClMO/DucfH9Vy1h31uXItipd1UBWINFHXzZ6FTHtegsDuogYQ7Z+OK8c0DvUhRRu3JT7DlFncPNOiHo2XGqg5BQSMs9jSicOituwtnWa+A/8fErCd8S0TWk6+IVU6BfoCjAx/tjvZdjCeUpVvuyEy9BPBQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Cp9iVOjlJiuMun3HoqVrBm+H1Wmi1V+lEkUPqoBtjdU=;
 b=oDPZNlDi5f8fXGbpIuC5okJg/a9Nj4H6PrvXe62AS8Flx04F9FI/oGQ51WPcU0dIRRi2PvWXz4patNOS4mX+GP47O0wzkGZIS/vt+hB5Q1ZtoSy2IQrgKoxmTbtYp92HscDFMv4VLsMfn4Eh9B8sQ1M4Z/On2xBntCWPFGiHyL0ji4m17B9BIQivCiH4FhYi1AcX875fKmsYTclubx9ThLshXuK/4PPLRGzOzCbutKwLeY6t1Zgmgn/J+3C0XTK5rBl+cACLQTPkpAGy5rfUKEuFegm3W00i2gWOTNnG/hMOcUR+YwmIX34aYNXvxaK8d5Dwe8OVucMPTDZgkuz0Lg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Cp9iVOjlJiuMun3HoqVrBm+H1Wmi1V+lEkUPqoBtjdU=;
 b=edO+tAkPtL9C14V6IHnYmig+sy59kc+5TNiQNb3ufntEXd/nDlC4aqPJbvrF8AlDwYfSJ/x4qGicda9ys/Y5yLfxAvK1tvCSoEslg2GTO0CBEEHUDg+728jF+2dirAE8e7NhcdN1XXhRud7ICcYVaDV6CCjwl4HzPtQj6Ht2NEYhKxIkFzklzoRDTOJJ2jgveb93YHPXHcK5x+m88XRr6OxE35fuDeH5vVNC1va/27jkc/St9Uc51RLj5gBfWaYzcgwd9EDSN+TDvCKHWD7EPw+ijrhlSQCRD+Hl3V3NhTOhExiPN69Xe3C+76PagywZmz+ynL2DAsCdNnj9wevlHQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by AM7PR10MB3573.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:139::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.21; Fri, 31 May
 2024 06:24:27 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408%7]) with mapi id 15.20.7633.018; Fri, 31 May 2024
 06:24:27 +0000
Message-ID: <df20c028-e727-4ff0-bef3-0778480a4d0b@siemens.com>
Date: Fri, 31 May 2024 08:24:26 +0200
User-Agent: Mozilla Thunderbird
From: Jan Kiszka <jan.kiszka@siemens.com>
To: cip-dev <cip-dev@lists.cip-project.org>
Subject: [isar-cip-core][PATCH 2/2] linux-cip: Ensure rebuild after changing
 SRCREV_cip-kernel-config
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0431.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:d1::19) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|AM7PR10MB3573:EE_
X-MS-Office365-Filtering-Correlation-Id: 1f4f268b-c687-4b93-76ca-08dc813a5271
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|376005|366007|1800799015;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?dUxsVjRhVXlxMEhwZFVXQ3daNkhvbElTTUFjTnh4b0hNTWR1WDNYYVlNMnFC?=
 =?utf-8?B?T2R1cXhNZG5zTDBscmRsOTNucXV3ZEI2eWl0UzBrbE9meHM2YU5zTGY4bzdu?=
 =?utf-8?B?MTA2NFNTUGhmcUQzbTJMcUc0S3l2WXJwWmlsQS9VNGR0SllyUWxKYnk0eUtY?=
 =?utf-8?B?Z05qZThrN3huUVlkc1NDNEdlU2l1R1dUVStTdGVZeUkvYWRFdStzWWplRDRQ?=
 =?utf-8?B?ME5mcE5DZ2dGYUg5L25RdTdwcnl3OXNnZE9QZkxuZ2szdXFHcVZSNUIxdWlO?=
 =?utf-8?B?QnB6TUkyMlBNZ0puWlp6SGR2Yi9FMUtpeVZ2azIxZmUzWlk0dVdSN2plcVNO?=
 =?utf-8?B?cDFLb0FqWlZpSVdoOGNGTzF2Rko3NWEyR3ZhWFA4K0VKVnFWcFZ3Z2hydnhs?=
 =?utf-8?B?WnNzZmdGMUNFY0h2d1FQWEhuRXZHWkZrWG1qcHRWbjBuQVE2clpjTnFjdW9v?=
 =?utf-8?B?QTdYY1hwVVEwcXZ6T29BbEpYQTZudEtXYXZNZlBXd1JONCtOWndONGVBVFYv?=
 =?utf-8?B?dTd5SisxbEZmT0tueUJwRTZPdHNaNWtveFB4M0pGTTZxR3dsOENXc1RnWDQ3?=
 =?utf-8?B?ako3dE1wQlBJNlNOaEhZMnE2ZlI5bkxRM2VENmhiOWp4WlRUbTJqU3NZSllq?=
 =?utf-8?B?Y0tobTdNTXI3ZFV6alE5c0V1QUNhcThPV2VwdmE1aEZhbWhxTURRNkQ0R2lT?=
 =?utf-8?B?dFhGN3B5WmNUbytNc2doTzJQaHZJbkRzT1JCMkFLNWEyVjdZV2EvN2dDakUr?=
 =?utf-8?B?T2RROWdIVit5YU9pZXlzc0FVbDkwUzlOZzRTWko3M0VUMmlRa0RvOVQ4UzYz?=
 =?utf-8?B?VHJxL3hYaTFCOU1iaXF2Zi9aaEJ1eW5vd25EclM2czlCQSt5Mm9nZHNtaUVx?=
 =?utf-8?B?Y0JoWTlrTHhVekRsdVp6UWN2dmQ4YUw3NXFLblg4eTcvMFlTZ3B5ejZxRUlT?=
 =?utf-8?B?MDZqbnBRYkFzTExLWm9HV3pDM0huNU54bGxvbmxwQW9wYVlCRmZnaEhvc0lG?=
 =?utf-8?B?TWFsR3lja0pWVlZEYVNRL3JidkIySkNEZmF2R0NPWENtN0RaS3JQdHdaMXZ5?=
 =?utf-8?B?d3BtTVJKc2ZkQ0RPbjVXU1gxV1VaZ0FBTlpsNHpENEYrR2dLVEQySXFHMG1O?=
 =?utf-8?B?dVI2bmZ2NUN2WVdvTFJOZWx5NldMRFdiSFlud3NnQSt3MHdVWVIvanJFSWlZ?=
 =?utf-8?B?WFR2V3B0RjlvdGJiRHNlN3JtNjBSZkowb0ZzaVY3a3czSGNKWUYwM3R5Ti81?=
 =?utf-8?B?QnBpNVdnOTVHdVZuWXRiZGY5Z29vUzZadGVKVlRjQVZJemdnZlFxT0tPUTFz?=
 =?utf-8?B?R09ON01oZ2JuNk5rQm90QlJ2alE5OUxUNTYwbzNjODV2UDRQOWJMbm1ybTB6?=
 =?utf-8?B?bmc3YUxzdU5OQVdYOHVuODBiL0RFVlJNSHV1UU5ldUx0NVZMSkF1OU5sbTg2?=
 =?utf-8?B?RWJGT1prb3lzM1RsNFIvSUpneFJoK0FyNXREWk1KWHhEQ0dLcUlpWUsrSWJ2?=
 =?utf-8?B?Tm5oaER5Y05kSkYyU2kwajN4dzdpdEQ1N3pSRG12UG1XVmxEMk1kdUpKVHc1?=
 =?utf-8?B?VFZTRFFEWTkzWTk5bUorYnl0L21ZV2psNzZScG1jS1RpREFEVzlqZC9pQlkw?=
 =?utf-8?B?WjJGcHh6WkdqYmZhSDVDdXZZMmZRWVRNdEtQSHJXSTJyVlJuN0pBUmlsL1RN?=
 =?utf-8?B?SXBXWmhmWEJLMlF4ZTBJLzg1U3pTSEhOSUoxQXJGQmgrMjB2eUo1anp3PT0=?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(376005)(366007)(1800799015);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?U3VSMnJoWXdrTW90QUxNd0VzUEU1ejVGS04ySGVNOWhBeE9pQXZDdVlrb2Rt?=
 =?utf-8?B?Zno4emd2RjhqbzV6Q1IxaFBSVzE3L2ZaVWJ4MmMwb282bEZHQXRpcCt3bVVT?=
 =?utf-8?B?bEJUMEI2M1hSNXJMR252Q1psdjE1d3E1R1pkYzVGNUFoRU1ONXRXZmFONmZV?=
 =?utf-8?B?ZkhnWkhzWFVTeUtBb20va013dDZqL0JQbk5melRZWnd6b3lwZlJ0K1NLS0d3?=
 =?utf-8?B?SUJFWnBiU0ZLMkRLcUR2S0huS3JoRWNxR2N5Z3Jibm54UWVFUkNpYWFiL0R1?=
 =?utf-8?B?bUZRZjh4cERmQlYwOWlYekhYb0l3U2FlZkg5Y2ZnNFIyZ0tnay9OOGVsQ1dK?=
 =?utf-8?B?eXhiVkp5Y1ZCSzVBODkxY0FKR0pnTG1tMUQxTGxCZnp5cU5kYVhpdDQ2REVP?=
 =?utf-8?B?UVlmckxWbmZYQjRxK0M1OGhjRTI2elVMVW5zRW8rM21xOEQwVVFiN3V4ZTVX?=
 =?utf-8?B?YXVwTGFFaURjVU96cy9kcTlqa2NYN0l2RC81dGx0R2VCQ0M1VHAvVUdzM0FO?=
 =?utf-8?B?cEZza0xCcHFqNUxyK2pDdVVYczYxVndvN0Y3VHRmVHZVQ3hGYzU3Qzh1OC9j?=
 =?utf-8?B?OEdmcm5XNUJNTXJ5SFdzYncvZkF1Y1FZLzdLMklBaUJEZjZXM1dtaTM5ZENH?=
 =?utf-8?B?eTllSEZRMG1UQTF0ZitnOWF3anRMN0kwVW85eHBFNmJtM0ZZMVdML1EzbmVz?=
 =?utf-8?B?UUF5STJoeFovOUw1TGUrWUxZdjFBSnkrVmIwQjQ5RmxtNFZvNklndjhKRytI?=
 =?utf-8?B?bU5abllrTHRYUVpFblBhK0JzRWlmaVJLOEorSVhLRnJ1ek1rU3grMGhlVjlw?=
 =?utf-8?B?WkkvVHZ1dUw5NFMzTGRySzN0NUVRMkd2c1ZyRklyS1VScG92a0lyRDlBbXZG?=
 =?utf-8?B?UnA0SXJKeTlzc2ZDNjhFMndvR20vYlVIdW1UT1M2WFUyMklySlJlQWowVi9Z?=
 =?utf-8?B?MkcyTVd0RllHZHVoVFFyQnp0NDdMQkVlTko4OVlVNitiUmxQdkpWZHk2d3E2?=
 =?utf-8?B?RFl0UE5vOWtweTZtaEFaRjdXL05ITWVBYzBybjhjY0xvdVlRUGlDbkJTdXVZ?=
 =?utf-8?B?QjllOVNJQkFVNVRnYmhXWnh6NXBwN1A2c3FVdm5kV2c4dnB4RVVzMkRvd3Mv?=
 =?utf-8?B?a2NncXhqai9VV3RPK3FYM0lXOTFtZXo0bnZOMElwNFFNRUZGdnZMSmczMlh6?=
 =?utf-8?B?N25hbG5kMTc5d3hKYlpIb1Y4RzJEbno1ZTU5MmI4dmRlWDNkY3dzYm5UV202?=
 =?utf-8?B?QUdYZ2pOWWl1WlZLcFRsOCtLdHNQM2ZhWlRRZ292NHFORVpubnNFaGtZdkMv?=
 =?utf-8?B?aU5mcHdRL0RZNkxITDgyVkhjMXlHRTFlSTNmbE5yRUlaY1JqbzFnWXY1QkZp?=
 =?utf-8?B?bXJBQmxxbEdpWkJaMEo2c3Nwdk00YVFmem9LVkgvdTI3SHQxUVdyTm85TENI?=
 =?utf-8?B?KzJFZ0l0aWZrelNkNWQwQm4wSEFKeG9oZFVGQlJOSVpwMWN0R2paQW41ZElp?=
 =?utf-8?B?cFNPRnZzWkw4MlJoRllJK29tRGdkcVVXZFU2UzJHbHB3enZ4WXpCcXJldWp3?=
 =?utf-8?B?Vmt4ci9xRVd5ejJvTVdWbStrSmNsa1owSlhoTTVsOWNOb3gwajdUckpRUUcx?=
 =?utf-8?B?a0RpVDBRRkFlVXlGeFlRR2pTTDRCZm95S05wTytOVHkyT3VsdXN6OTVZU2Jy?=
 =?utf-8?B?MDBZQWpIN1JmRWpFVjZLSk9HeTFrYmI2Q2JCbnZPdW9seGFyWUkxejlia29v?=
 =?utf-8?B?VVJVTnRaWmtqZUdVaUhXNnNXVzcrZ0dCN1EwaWE5amFNMVFHMjlkSExkMlJS?=
 =?utf-8?B?K29xdEdyUForOWpaNEErNWZDRXNGeVhud01wRnRCd1dDd1hudUdDUkpqVkg1?=
 =?utf-8?B?S2RRdU56OGM0aElNNTE0U3JvUnBQa0h3VVYxSlVtdUZMOWcvT2VnRDlqY2J4?=
 =?utf-8?B?OEFxWnJwUnM5SFQxNzhBcWNaNndGRXdkS2U0bldKSG1nSm0vQkR4RS9acnNH?=
 =?utf-8?B?ak45dGFVRGJDWVFmK1lWU0JpRndxbFIzeTFHMXNZam8wVUx3NXorM1NIcDNa?=
 =?utf-8?B?Z3VDaEZYRzBGZGtSNlN2TzRKRWpIODlhREU0TVdjaE9VWk5JN3RlVDBPTWRP?=
 =?utf-8?Q?uXdds8/mOIggTIFwnMrwh539/?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1f4f268b-c687-4b93-76ca-08dc813a5271
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 May 2024 06:24:27.1795
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KmijOAdbAu3akJP18okie+FcDq91q3+oDVtBAPfoYPK1JSA2mPT5KfmRX+wMWcs9G3C4cICxe9Df7y2E6frujg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR10MB3573
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 31 May 2024 06:24:33 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/16075

From: Jan Kiszka <jan.kiszka@siemens.com>

Without help, bitbake is not figuring out that there is a need to fetch
again when SRCREV_cip-kernel-config is updated.

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---
 recipes-kernel/linux/cip-kernel-config.inc | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/recipes-kernel/linux/cip-kernel-config.inc b/recipes-kernel/linux/cip-kernel-config.inc
index dcb1b90f..1656728a 100644
--- a/recipes-kernel/linux/cip-kernel-config.inc
+++ b/recipes-kernel/linux/cip-kernel-config.inc
@@ -15,3 +15,5 @@ SRC_URI:append = " ${@ \
     }"
 
 SRCREV_cip-kernel-config ?= "93b9ba271c14556a24b3f8392d10a8647b496f1f"
+
+do_fetch[vardeps] += "SRCREV_cip-kernel-config"
-- 
2.43.0

