Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 340BBC53219
	for <webhook@archiver.kernel.org>; Tue, 28 Jul 2026 18:22:32 +0000 (UTC)
Received: from PA4PR04CU001.outbound.protection.outlook.com (PA4PR04CU001.outbound.protection.outlook.com [40.107.162.46])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.2924.1785262950746326761
 for <cip-dev@lists.cip-project.org>;
 Tue, 28 Jul 2026 11:22:31 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=Xb4dFI5H;
 spf=pass (domain: siemens.com, ip: 40.107.162.46, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bgRjzhijXKZVco3b46d7vIC6e9smlr6iThGrlk5d4hIGl0sTf+9zxlykmqlYfnZCUH9kLGUtqb9rEZkcLVP9jjL1n11+ffs3hB83Yfg0mBipPcw8NIpOof/u92LyTnjxoDzajQWw1n1nuTRmSFKdevrzK1zkXIZ+U88aWvg/PVE2YIlHsLzKh1ea4zfeKmzEPKaPcbIvQKNsRNdIOuKngjUfyvJFXNep9PhwwehRNhj7HpsSq2Z4C235W6VCu6q2xpMKkEx/HidyTYWzA8IQWxLeQY7fLxPN58XwGbif+8WHjPLb29MtgLgkA9kQt8bEJYGx1gjLNebgJuYu7cTVvA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qpEBsjS8SAo9GGgjkbWfKON4zu9ukMOztdInzM0+9Ls=;
 b=YOK4NG4hHFZ85N3vZUI7ZJXnk9hECyu7sMlFuNnBknUJU1hU1oekk4N88uOjAedV5FGbqHttkhNPQvZu/ehrPNmD5xbeZzWmOG0S+UIH23qgbbbQkoui3EGwyuEWRfLpGu87HM/CEMMyYY7vSYQHuGXTxG6OgHpkRi93PREu+r/OnX86IQmvsXKGQH/OQVB5xid9ORqo/VgFWpPeMp1E1KM2BF0upJJhl0WZ3rpHsm4LjoyKn6BzHf8AYksIclx9qECJGunf6e0LIocY/TsxpbIOJT+J61IhUHeSDzziy8vw1GN0Tz7/rgZhNEuECk5p8CcK02BoOI8YLgBm5GVxIQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qpEBsjS8SAo9GGgjkbWfKON4zu9ukMOztdInzM0+9Ls=;
 b=Xb4dFI5HcdWLNzmGFde1FZcKaI4wIPukX9IoqAQCPo9SkXYAaQ2VrPp6bg1s2idepCXiAxk4q5agfvXYV46UX8v73WNNMYl/tAgNn9NOylp3k/nISjs266ACMqBeEOMk3YOPP6qfC4+9EMiMRKaWR2HmjEtLwETAG+xsZKy/b85bSVNidPWq35uiKkcV4I69vvKAdDPZeJNZndIn5iMRhb5jySpIQvmPQtfT8qhKslY7XpwBzqarQcxGbz3MssBUmPIqrbG8J0w6Su0BnKmNUHtKjDVMaIaL2Hf29Wb2taI+Z3MpX207EgMILyT2FUS8cTHFVJQI8yDLxGR6cSzaKA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by DU0PR10MB6876.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:465::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.245.13; Tue, 28 Jul
 2026 18:22:26 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::be9f:e8ca:ee9:83e1]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::be9f:e8ca:ee9:83e1%3]) with mapi id 15.21.0245.012; Tue, 28 Jul 2026
 18:22:26 +0000
Message-ID: <39850dcd-68a9-4f37-ba4c-fb3510f4a95d@siemens.com>
Date: Tue, 28 Jul 2026 20:22:19 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [cip-dev][isar-cip-core][PATCH v2 2/5] update Isar to contain
 rootless changes
From: Jan Kiszka <jan.kiszka@siemens.com>
To: Quirin Gylstorff <quirin.gylstorff@siemens.com>,
 cip-dev@lists.cip-project.org, felix.moessbauer@siemens.com
References: <20260728131231.117214-1-quirin.gylstorff@siemens.com>
 <20260728131231.117214-3-quirin.gylstorff@siemens.com>
 <7a82d63d-ce93-4554-a1c1-ce1e01065ce1@siemens.com>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <7a82d63d-ce93-4554-a1c1-ce1e01065ce1@siemens.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BN9PR03CA0244.namprd03.prod.outlook.com
 (2603:10b6:408:ff::9) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|DU0PR10MB6876:EE_
X-MS-Office365-Filtering-Correlation-Id: be3554ec-fb88-4b79-fa58-08deecd52b25
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|376014|366016|1800799024|23010399003|6133799003|18002099003|55112099003|22082099003|10067099003|4143699003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info: 
	+iF0ALkSWFk0ov5Yf0zbqRHzC7g5Xmc85u05rywQ2m12i0E+VNGLWcrukWawsHma7WGjTRHyMvyhnhfvp6eGDxXFgojShsczuNfTT1zgBTnaafEJGKmqNLfH3E4AEe4wuzvNCZAk/IMoLJS7V5DdajwBrbFEK1I1PBBCGTYPhl1L5UwvDkXNjgTACmxjJGuF31FIf/6ua68u5LmCBkhDUwE2jcwfnoZ0koFzYw9qmKbkC8Vl92389wtbOIpWabwSntBzFHuY13+QKeklv9j7GOoloBtZd73vGwEvhby0adhd9vLHrB8rL9MPaFNDX8FXcwH87ByEize0DWB78ZpGK0N5sMEEjuVTC5gYKYevJV0PzplbjMSEDn62TqZAbHo6FGgobF1Y7QN39v//NyyzNCn7b12flPEPgBNZFKMT7An1FQv4obUjjmLZmHdzcOMvC4lkvP6UPmHQox+KZmqbgA1GZd3ZW8LQTxJCP8k3W/801cd8Xe7TKcm6w8zeQUnEHY4RFb6uSUtWKZ8rqiWV5MSSlcS5/h+Z/KG18VUruQsaxBNx/T5z2ZAJnqfHOpdJ9hbRGDxduYq7ZZD1fxB5Y/EGoFszROGbIq0dOMccnk/OcVAf+YFp6OdvE8g2XBa0I68MoCvdjD9EeVEenoZDv+G52QlM0ss1pE0p79XSyOw=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(23010399003)(6133799003)(18002099003)(55112099003)(22082099003)(10067099003)(4143699003)(11063799006)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?N1BFbG9LNnRQM1FUMHEvay92ZzdsZmQ0dDkremNRRlJyOGoxVDdPdHlpSmZx?=
 =?utf-8?B?VDFMd1k5dis0d1h2TEh0STJsaVhVRE1kZjdrWEdUR01YTjN1Sm5kckFybjhy?=
 =?utf-8?B?Slk3MVNkU0dyb2NwQzJXQk1CemhHVSt2ZGRHVE9Ta0ZkVFQxeFlGT0htRHlC?=
 =?utf-8?B?Q3dvRkorU25JUkE1ZVNmVC82cGZvVFF6dGswVzBDcWdEMWJvUXJuLzdrbjh4?=
 =?utf-8?B?VWtaemJlMFI2VTJBM0xOdVpKVE5KekRiU0dXNSt6Unp0VzZuRitYbXVFWUpx?=
 =?utf-8?B?Q2xyUDhLNFRsQ29WS2FBRGkyNkFlZHpJcVd2dTh6cnlYTUplUVNLcGQzRlkw?=
 =?utf-8?B?bXpvNVRZZ0dMWVlBRll3ZGdIdVYvdS8vVmVvZVlIanZBeU92SmZZbzVLSzV5?=
 =?utf-8?B?ZWpLa24xUmhBU28zTWMzWjJ6OHlsYjdPNnVMTHhDN2JPK2MyZzVJZGpYanYr?=
 =?utf-8?B?OVFmQmlUanN0Z0drK1hKUERVV3pNM0I5UnUrb2ZjeWx0VXRGMU8zeGVmYmFN?=
 =?utf-8?B?Umg4bUFabWJUOUdxZVMrYVJobFRlTGdqdUd4cUk5d0hvcXI5YVZYWTJtY05q?=
 =?utf-8?B?ckVMNGhRMU01dUcrVnRZR2UwWWtvWW1VbEFsYzRweWVuRW85eFlJeldURTJv?=
 =?utf-8?B?OVF5UnJSeUtZSGljWnhvYitTMnJlQ2k5Q0NrbDQvQTFmcTBkYXFFM0ZRMDFl?=
 =?utf-8?B?d1ZQN2JjODBLK2NzK3hyMythaGtZRzNyWlpnbWVkbVJ0eUI4SEU0aEJnVEJK?=
 =?utf-8?B?TnhUWGpGencxR1I4Slp0REF4aHI3Q0NFZjM1WUhZV0lwQVl1VkdvUTFzV1JB?=
 =?utf-8?B?M0xNdGFlWENkdU1nVWlVaEE1UVRqWE5WWWxoUHAwQTIxcWNMcjRoOTlSaG4r?=
 =?utf-8?B?VUxXZVRKbmlTditsaU9LTTVpMXAzMmM0ZGlUN0Njd0dnRGJzbDZsT0RnODdQ?=
 =?utf-8?B?ODFRVDIxQ3laTjEwdTEzdk96TGVOMTJPOHBpNG45QWl0Z3c4QjF1R2hacllB?=
 =?utf-8?B?cVdOZTd3Y3BlaXpKdDV4YS82a2lKRlUvbmRxU2FHMktrcllqL0JXUjBCNnU3?=
 =?utf-8?B?RXdqWDFRN2cvKzdpTzZ3QURMZVFLTlJrQ2I5WHZNdERybUhRYUU0eTRIRyt6?=
 =?utf-8?B?dVg2K3dHRkFaRFA1YStkZW0xWkpkeGhVbTVNcU5DSWViVkJINDlqZ2d2cEFs?=
 =?utf-8?B?dS9Ga0E4a2xsaU5HenF2YjU3cS9OS0FyT2JLT2pyblJxN3JKeUNwdFU4ZGtX?=
 =?utf-8?B?NkRyMWZqVG1jZGF1TmZGNFN1ZDIveTZWcUEwTmRQVklVQ1hMWHh0OThGV3F0?=
 =?utf-8?B?N2pTWEtDaXlLMExuWjlWZHBsckRRWmlFanBHMFppN1JNeUsrSDZGYklEWTZa?=
 =?utf-8?B?dTdaZnR6K05LZjY3V2Q2UTJnVDlFZkVQN1NRNnBXOGpUMEpDVEdZdzhQVFhV?=
 =?utf-8?B?NTc1bTlLK0Q3MmxqSUdnUGxUUm9ZQ2FtcVQzU2JpN3VwUmkyR0F4STZOcUZr?=
 =?utf-8?B?WlZuV0xLcmNOcDY4cGZ2S3p5UWxnbG5zSHZTdnA2aU1HVWx0Tlk4Zk44MmNq?=
 =?utf-8?B?eTdpL2UwUDFnS3lZN2tMNzIrR29SRVNsWGc4WUErQjJUZDRFUEhOQlVOZW1n?=
 =?utf-8?B?bU15YXRJZzFtOElVdXlGT3ZSaitoK3l3QVdudkVJcjRPZUgyRjFGbG56SVNV?=
 =?utf-8?B?Qk15WDlwZ21yc3JNcWQ3OHpwaGVQNSsrZHRjcVpYcVZaM2NWUTFLK1dhcVcx?=
 =?utf-8?B?QTJhb1dhdlZNdnUweGJYMDRQWFQzSnpQcTI3TlRKN0VKSG9qVGVCTVhZb0Jj?=
 =?utf-8?B?RDQ5eVdwSWV2ZFlTL0lsM0dqdVZvcTRkeU5YdlIzcFhNekdJZFVzdXNHQmo0?=
 =?utf-8?B?WHdITFBoYnJ3RVFzS3lEaEJoM2Jha0FZOFlaNnRFY25GOEN2OCt6aVBFWnA5?=
 =?utf-8?B?SkxxM0tpRWRFZ3BSUU5YWTVydjlTaTNsZjFMWXhRc1RGSWFlU0w0c2tQSDFV?=
 =?utf-8?B?MS9qazZwcHAwLzdSWVRBN2hMSnlzdjlqWkMvS2VwUG9xM3Q1azdyWEJ6UnNY?=
 =?utf-8?B?V1lGbGdjKy9KNE5pL0ZJSGpvcVl2eHFOOGhGYUl2MjAwWG4wdzJTczJ2MFZY?=
 =?utf-8?B?Nms2TU1DNEFRalNXMXNZUVgzVGw3L3lmcEhDSlcxejVVcmtlTTNCMmp1OVNO?=
 =?utf-8?B?UzBGVUMvdDBWamZzOFdpdDg5bmlURHFwMGVpY0pjMDRFY3R6RmpLTEhZMmlq?=
 =?utf-8?B?UldyaVc5VnhMMWNPM01DZGJBdERoOEl2M0dNa0pKUzdRZVJNU1FzWG44TUxa?=
 =?utf-8?B?ZnV6NWJuc0hOZTczUHNYZ0lMTDU2L2JwSFEzVnhuUHdjVklvUHNKUT09?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: be3554ec-fb88-4b79-fa58-08deecd52b25
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jul 2026 18:22:26.1502
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UgHD21PuoKIP2hqlQsg33iz/X4jgMCaosLVZBxUNeVbEKyx74JK5PvY4JoDCq2qs3Hj3oUWzqXWwfnj6tCIRAw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR10MB6876
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 28 Jul 2026 18:22:32 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/23809

On 28.07.26 18:55, Jan Kiszka wrote:
> On 28.07.26 15:12, Quirin Gylstorff wrote:
>> Signed-off-by: Quirin Gylstorff <quirin.gylstorff@siemens.com>
>> ---
>>  kas-cip.yml | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/kas-cip.yml b/kas-cip.yml
>> index 6badc7d..cbccf63 100644
>> --- a/kas-cip.yml
>> +++ b/kas-cip.yml
>> @@ -22,7 +22,7 @@ repos:
>>  
>>    isar:
>>      url: https://github.com/ilbers/isar.git
>> -    commit: 3c645ee8dcd3d2161b93a3b2f9808fe1829850e7
>> +    commit: ea319eb835aea545f23266ba15358bad029a56a0
>>      layers:
>>        meta:
>>  
> 
> I'm bumping this to 8ae7612dbc72607825e3efce6c3f8eef66200f2d because
> several related fixes were merged meanwhile.
> 

...which requires more changes to isar-cip-core. I'm using your patch
now and will send the second Isar update separately on top.

Jan

-- 
Siemens AG, Foundational Technologies
Linux Expert Center

