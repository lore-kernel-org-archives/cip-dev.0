Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C143FC44539
	for <webhook@archiver.kernel.org>; Wed, 22 Jul 2026 11:43:21 +0000 (UTC)
Received: from PA4PR04CU001.outbound.protection.outlook.com (PA4PR04CU001.outbound.protection.outlook.com [40.107.162.1])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.45803.1784720593203225193
 for <cip-dev@lists.cip-project.org>;
 Wed, 22 Jul 2026 04:43:13 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=GRAY/rMA;
 spf=pass (domain: siemens.com, ip: 40.107.162.1, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=a4oYbFJ6HXex/M3mX4iz138uzud1ftd51qgaL7u5dzXGUDEMl93rsd7WESdfecFfDimXe1fTTiXdrCxS1zBgCTVkan1ar/CdW1y5f3ZgnxWaQPmqiIoPsaAkTyEaC2nf6FdrcCffTA8GItYYj7YbM3JNdYbrS9xJodimaTjaTmVYZMjXQwBmO9U9FHdK6FjeApRvzWS0vw9tWH+dzUTPH1XXr6rtCBH4YL3rebaGfTgCKRMd3I2d+1t7DrybkOJtx0yiSKQyhAZhRmir+NVLIHCBNtHY/C4QnKR8uK77TrQ0Y9+K4NDsUfAKeHatQTIqveztsyRWoZdSYLUqUz9KyQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/mt4H6Palcj1DUn/zibdhl0lXUG9EGiN+EBNJXzy58A=;
 b=uKosLtz1dtgRxXDi/ELJ+ThnLnfR48M7PtqwAwDzF6R0Aonk87k9Ol6V1At2aBDy3n8TxHCKTU1V821AubulN+2bCdfADQ3Sk0qtSIUtptn/UhYt4IogKWIbaekbxITAQfYvfEIIn2UHx3V5YP1rmTr650fPT/I+L60lePyx59TpKqKdn/eTP0aAvQBEO969Cu+RckUxqQHeOjJ6WWjyLN9tpFMPjtkQA7StUx3TxaHvDt5aGq7gVDayqpqwQHAAdCKr+unlRKYuKxxG3h/41RZd4/hJejgTsbf7ch5xtfiPSEml43M5GzYG6+OVaO7VdEyMLy7VVEfJz+aIFLXm6Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/mt4H6Palcj1DUn/zibdhl0lXUG9EGiN+EBNJXzy58A=;
 b=GRAY/rMAK1/k2JNred67tg+VSXq5vEBH1KJDpPLYZTrn4agyTQ3Nfom8eheJLchWKKdUsZbJNmKD2Io+ksDBfr6P00wFOHKDNcu0Q74ZwbKJCdsXH0DPBM04dQkaPaBg+mvvqQOy5oTdyHPzXesqAYiu93wQ/M8cM7VPtoS0t2cSS0vr2xFDskfAsHJjB1BsY22yl8NDgmmZgwb6D0rGFSEmXnwFZJSSH7kIz3o31hU0Y+m0uABjHK2qMIY5yBU45/zYEe9jbK1lxQrqBNQWU4JxGNluMDixWtbVri6i/9c4PgEsJzcfqKKE1zaztgXhiqtxvymeliebnCXuMilKVQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by PAWPR10MB7368.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:2ea::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.223.18; Wed, 22 Jul
 2026 11:43:09 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::be9f:e8ca:ee9:83e1]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::be9f:e8ca:ee9:83e1%3]) with mapi id 15.21.0245.009; Wed, 22 Jul 2026
 11:43:09 +0000
Message-ID: <9648c32d-f4f1-4bc3-9ac6-3e81578eaea4@siemens.com>
Date: Wed, 22 Jul 2026 13:43:06 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [cip-dev] [isar-cip-core][PATCH v1 1/2]
 swupdate-handler-roundrobin: Keep Lua version 5.5 for sid
To: shivanand.kunijadar.v45@mail.toshiba, quirin.gylstorff@siemens.com,
 cip-dev@lists.cip-project.org
References: <20260720045903.733394-1-Shivanand.Kunijadar@toshiba-tsip.com>
 <20260720045903.733394-2-Shivanand.Kunijadar@toshiba-tsip.com>
 <41d69f3e-2719-435b-8485-f8218f3a642f@siemens.com>
 <TYWPR01MB1106381B97061401A6E0139B3C5C22@TYWPR01MB11063.jpnprd01.prod.outlook.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <TYWPR01MB1106381B97061401A6E0139B3C5C22@TYWPR01MB11063.jpnprd01.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR2P281CA0165.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:99::7) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|PAWPR10MB7368:EE_
X-MS-Office365-Filtering-Correlation-Id: 4ade8368-a76e-4e86-435e-08dee7e666fe
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|23010399003|376014|1800799024|366016|6133799003|56012099006|10067099003|11063799006|4143699003|55112099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: 
	8zvJ4js71pz0K/PAA2qsv3nfRc3553r6n+LEfrsyfWP0Fqyj0oBTJ8EpQidiFyYomT6YeIXMLV7N2zLBv2cYP9voqsRKOB+aPv/m/IVCybkMZvZGIAvykipzn4aRjDNPV+UyNtD8zzDbx/cmlVoSnaWGGkbAst2gyAnxbzwTY5dqC4Jv4LJ6X8mdfWtbLz64aHMPy2eojpFz4MkZfBR67RmvJ2zl3er+c06kXgeIhtuqau+3IIcrZBjXx+RxeWpPgvCl3If1scHl+64iM4lgMeMEExaBfZHnR6OLObc5UHSIEKqZqyFnO0vcmvhVM7KbxnIcRlMtXSdEFGBkcgSAI8lbfbK60cxrQ1fm4aQg8vLUb7O3UJCofMuMUEenSF3IaF9a/DmEyZKSyWp1+3jyTTH2jUN/aCeTi/IxU/Ecd7tn3b5Xxq5faphRw0hBrCYVakV77NYo4yKi9i6x2esg0Z9BhTYJyvE8ik/RthpwFSvQm+8+fgB2GRbx70bDLjjaPn0+H+GBgFQoINX6vGDocyqZp2jrfkl4hvP61w1AshSHd352XbKI6ZAMIq/+s+YMwvuii0U1zqukeJhQErvwMO6vnfO6Ap/3QXQZlrdeDdCI2FDX4Ev3K0hn3FrL3+LloTLEuT4CK9+YpA7H0nbGB57oAhFNTh71AeAL6FWIxLM=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(376014)(1800799024)(366016)(6133799003)(56012099006)(10067099003)(11063799006)(4143699003)(55112099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?aFh4MzBtTERjbG1yTnF2ZDFjNlllWFh0MzBGa3NVbUVEL2lXckEzTkpEYTA2?=
 =?utf-8?B?Y0RodktHZ0RXZ0xOaHNmWE1rZVJGWVk0dFpqZXp0NVR1VW1oLzNKM3V5YSs2?=
 =?utf-8?B?dWg2bDV3bzBtN2NETDNUQ1A3NjB0cCt0akh6K1VXYWRyd1oyTWwxTFVMRUJD?=
 =?utf-8?B?bHFxaEplRzE0MEl2OVF3b2VXemhLTGpEa1JkUUIvbWpEUHFBOXZpSVlHZGJK?=
 =?utf-8?B?MUNIbm11MUVQRG1rZkl3M21DZUg1TG12Mlo0QUZjVlhjTzlJNzg3cjE3WUVa?=
 =?utf-8?B?bFRlMFNnaHBWOWlzSm91MlBHNDlpOWJiQm9LOW9pUXJIdldPVUVqWi9FeGNn?=
 =?utf-8?B?UzJSa2VsM05vYnZNYzFtcE5DSUIwNlZ0Ti9BaGVVYXlSb0o1TVM4dFk0VnJj?=
 =?utf-8?B?MnZVY3p3WjRzUUU0SlZmS0hxOEc3YjNYRzlIcTFSc0hHL2JSQWo1MHJtVTI2?=
 =?utf-8?B?MGx2ZTVDeU1hbUVBcnA0UXlJcGNoOXk5S1pORWZKMmN4cTNzSzRla0pyeENn?=
 =?utf-8?B?KytnYXN5Rm5tODNVU3FOa1JiV2Jxa2ZmUDJzSU9hcHFPblg3L25VRWNERWls?=
 =?utf-8?B?TWJ3d21tcm5GVVRmWmV1c1Z5NHZXSG0vcDhicEdoUjN6R2N1MWtNdEJZSzZn?=
 =?utf-8?B?SXBuYUpEVmZFa0xrcUFRMjBLZzhzRzZnNHR3SEZ0UUI2ZzNPRmRIUjd6SW5t?=
 =?utf-8?B?TCtQRzcwTGJLNWZYMlNsRThDeGp4OEoyOEpqTGxNNlNBWmplU2lTSzBVZFN3?=
 =?utf-8?B?bS9rNU5VS2dGZ3VzRE9ZUHBHdkpsc0Q3c1FnWjdLTDVxVHBhRUw4UkFlK2VJ?=
 =?utf-8?B?a3hPd1hjeWdBTWpNMXFWam9EOGJ4WUhYRCtKd2YyVG9kWHM2ZkRrci9CajFO?=
 =?utf-8?B?YlFZU0FqUU0wT3BERHRLckpDRWQ1bkxua0lTMCthMWhITUUybGRIbmtiaVdt?=
 =?utf-8?B?cmhqWUN5Rm9vQUhkSnlDNUZkSmhsOVR4dW14TGNCdXFyWEpESFRRTCs4VDFs?=
 =?utf-8?B?NDVJOEFHSHZIQ0I3Wkc5NHlHSSt6SDAwekdqNzgzT2xmdldOSHpndCs1Z05S?=
 =?utf-8?B?UUZOaS9NaENjTWZOMCtZVkF6aExoRS91OVRuTElNQlBXRjZiMHd6QjM0OVNo?=
 =?utf-8?B?cnVETFUrYUJBNFdENUVEendkbU9TVDJZSVg4QVk1VmlESUtxMEM0d3I3eG1p?=
 =?utf-8?B?MlFweGNXNTlydmZHQkJZaTkzNm5rQWQrWWZ2dk9COXV2eWFWd1c2UmUxQnpJ?=
 =?utf-8?B?amZOR2czRFpvS1hzU2VpZmFUd01DQkRpTWFBdEpKWm96b0M5ZUxaUTM2S0Zz?=
 =?utf-8?B?cnpCdWYxZCtCdFc2UHlCd2VmUFkrY1hFV29TTWtYQUtLTVBJaG1tbkV3TU9a?=
 =?utf-8?B?V3pWVTBVMXo5UW5XY3hGSDM5WURqaW1YdmZaTHJ2VFdnNXBxZFdOZXp6bjc3?=
 =?utf-8?B?TlhuMkF0Y21hOHVldU1NeVJCQWQ2RVVIcUxabDVEcVhqV3lRV1FHcDdkcU9K?=
 =?utf-8?B?L1JVVEFkYS9hbTdJOGRaNithdC84WWVNV3lIMDFaVUxFamdZTjRFY3VPcmZy?=
 =?utf-8?B?eWpydUtZNWxVUFQ4cE44SDNMSGpqQksvSFpMdDBVTWt2YXdJSVRWeWpEdGts?=
 =?utf-8?B?UzNlMjNpaU5HWW56MU5GUGo4SFBXQUx3RDhRT3ZWUk54YXI1Y0Mrcm5TWWt0?=
 =?utf-8?B?dUttRDBKcDJlUTU1K3BJWVphVnNKcnIrS29ud2x5SW1VaHltcy9POXVPWHFI?=
 =?utf-8?B?RGtlaFJlRzdpeml2L3RiMGg1NnZ0cjU0VElXNXNpek9RM1VWMkplZDhIdWJs?=
 =?utf-8?B?bmNYelY5Smw5cWZuZ0VPUy94Y2NONTdDWGhQSERiWkhsamtPM21JakZzc0Ur?=
 =?utf-8?B?ZTV6bnVNTDBhaURiVXFaMjRDekJacDA4RnR1WGx0OWdvYi9MOENBL3BvYVJm?=
 =?utf-8?B?M2cwcGxoVUJ2L1pjdGVFV0FCNVdJTDFVV3NZeDl3TjZuWVRjakVYWC9jTDE1?=
 =?utf-8?B?WW1hV2NqUVBuU0JEU3hzTS9lbEpQazZjazR5TDVqMk5wZnRmZW5GNVFwUitH?=
 =?utf-8?B?TE00MTNRbElGcHRXNlNEVTd1NmtLWSttanBEaFVWWnN3Y1hlc2JtZ1NhZzhK?=
 =?utf-8?B?VnlzU2N4UURRN2NoLzVQMTE0WVF0dzUxSkdHZ0haWWRCV2RoTWc3QVQ5bzAz?=
 =?utf-8?B?OU1Ram9odW1uMEkrVEg3ZUxBeWhxUEpNOGZxVnljYWMwUHI1Rzc5b0xBMGoy?=
 =?utf-8?B?M0lYZWRPV1dmVVlsay9BcERTZ0JFYVJERDU2czNaS256c3I4MXNxZHhMWlVP?=
 =?utf-8?B?ZjlaZFhwV21YRjNlWFhZZmovbld6dFgwbUM1amQyeitRbFZ6Tnlldz09?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4ade8368-a76e-4e86-435e-08dee7e666fe
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jul 2026 11:43:09.2286
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ryULurT9Fyk4O+olzKZyfzb98K8OvqFjKTkhNnp+4wnnlfFjpfYGqwzsnmvw0HMhyK6zV2NLkjBaAetPNoFLYQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAWPR10MB7368
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 22 Jul 2026 11:43:21 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/23708

On 21.07.26 11:30, shivanand.kunijadar.v45@mail.toshiba wrote:
> Hi Quirin, 
> 
> Thank you for the review. 
> 
>> It would be better to pin the version for the previous version instead of sid." 
> 
> Does this mean keep SWUPDATE_LUA_VERSION = "5.5" and add version specific variables like below?
>  
> SWUPDATE_LUA_VERSION:trixie = "5.4"
> SWUPDATE_LUA_VERSION:bookworm = "5.3"

...and older (down to buster, I guess) - yes. Eventually, the older
versions will be dropped, and we can then remove those pinnings.

Jan

-- 
Siemens AG, Foundational Technologies
Linux Expert Center

