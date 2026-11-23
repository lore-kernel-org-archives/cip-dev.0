Received: from OSPPR02CU001.outbound.protection.outlook.com (OSPPR02CU001.outbound.protection.outlook.com [40.107.159.56])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.54825.1795444413465905574
 for <cip-dev@lists.cip-project.org>;
 Mon, 23 Nov 2026 06:33:33 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=x2OJBwWE;
 spf=pass (domain: siemens.com, ip: 40.107.159.56, mailfrom: clara.kowalsky@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sn2ybn6DT75GRen1ZV83wt2TyaK05cfe3ixL9XV3LWbR4p4J3aOOMMqFOnZjOs1jlQqd6pm7grDdS+TtdLLHeoNpw+d6WxG475AyWTCnjCq9b+Xy/JYkqlZk7kdO6NjuVdL8MiQvm2SaKabWsyJU99cRcreu5h9sOVAcD0QrhsJ5VBHloUytd3U3jOeQs1kx7Waa8XMQzlWlPzisOu4fYLgWTs2TgqVMEIoTlqt0IOwMxwVYUl6lnIZBueT6G143QdSAUbeO8k29DRWV5G7+EBKIy8Z4iZ83YGC3+bQjum1Tgqoq5bVR3+6ny0lGzM09F+Kr51g0L6HmYDef9h32VA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eAGPDDUSPrlbkpWBYaBYIDpVTXS3p4a+W6Vv1I4ywa0=;
 b=fFEiCP4yA005lMIupfm6eI03Z/A2mqevcB+5MlJzjL+v7qol+gaGeX+bIqOa7zz+gvriPwOvSc0YKrz8CaJxrduacMlWJO7Zxd8vBadS/5bfTDVRjHSCBGB+lIjKkvbgS7V50EK/igqIavLt0ZM9gx9Qeu51b2pI81Y0+76tMSA3SOhYhsJQuNI1szwaij7l2Ny8dBPrG5jRC0HLz8PBrn/VN4D8k7dr0IBuTTsnI3s3GFJlNAzKp0N9Kj+mpLmdQyQ4cABR6H9DRI8A29nF97scPr5L/f2CYutqkyL7tJr1oIkOpYodzDZvIPuU5Biv770MdZ4L+X3Rm8rt3e08VQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eAGPDDUSPrlbkpWBYaBYIDpVTXS3p4a+W6Vv1I4ywa0=;
 b=x2OJBwWEhtRvIO7m6eaKrOZoV+GFYYzSjpwRmVuEUGxboLefHURwhFcEnVsjqZhuWc+3hk+6GMxKUyD7CaUugZBEQGpPqRUnruAScui4llGoXa0+5SjABB4W5A9O/YGKMe3hop2PU6pdo1qtA0cOahZQnQBTaTV8XqpjdM/dd6Tp2B801e2ar0C8NGeFSKC7I6PtPkWl0c5pJh1yiAdr2H11/qPaUNlYnaEjGLGA8HMXG1kztMiwRPZse8UCzpO/4M6dLuzIrXXfFvJjS2ipm8/0dgzBoDn2s/iugpzFqOOwjMsTf0VsX7FZz9tMdcDbIEmeIq084WaSz00B7eo8og==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AM0PR10MB9645.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:740::12)
 by AM7PR10MB3287.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:10e::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.662.3; Mon, 23 Nov
 2026 14:33:29 +0000
Received: from AM0PR10MB9645.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::527e:14a7:bd3e:86be]) by AM0PR10MB9645.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::527e:14a7:bd3e:86be%6]) with mapi id 15.21.0662.001; Mon, 23 Nov 2026
 14:33:29 +0000
Message-ID: <29e2ba39-120c-418f-8281-fa2ac8871bf0@siemens.com>
Date: Mon, 23 Nov 2026 15:33:28 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [isar-cip-core][RFC 1/1] convert wic plugins to
 execution-from-host model
To: Jan Kiszka <jan.kiszka@siemens.com>,
 Felix Moessbauer <felix.moessbauer@siemens.com>,
 cip-dev@lists.cip-project.org
References: <20261118125412.2039363-1-felix.moessbauer@siemens.com>
 <51eed7e1-c4a9-40eb-bf77-703df28a43d6@siemens.com>
Content-Language: en-US
From: Clara Kowalsky <clara.kowalsky@siemens.com>
In-Reply-To: <51eed7e1-c4a9-40eb-bf77-703df28a43d6@siemens.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
X-ClientProxiedBy: FR2P281CA0148.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:98::6) To AM0PR10MB9645.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:740::12)
Return-Path: clara.kowalsky@siemens.com
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM0PR10MB9645:EE_|AM7PR10MB3287:EE_
X-MS-Office365-Filtering-Correlation-Id: e41aef73-fa85-438f-06c9-08df496ebdd4
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|23010399003|366016|10067099003|56012099006|11063799006|4143699003|261021135927099003|261026140227099003|261026135527099003|261021133027099003|261021121427099003|261022113327099003|261028144727099003|261026121527099003|261021130227099003|261102123227099003|261022115727099003|261022105027099003|261021123027099003|261022075727099003|261026130827099003|261009223027099003|55112099003|6133799003|22082099003|18002099003|4133799003;
X-Microsoft-Antispam-Message-Info: ONwp4tVEX5mwVCA0dm3QkaqJhjl6I0A+s5U0h4bOP7DzfY9gFA8Q5vQ79VHQ06CCZXiVO83+oCXh+SYkkdx22USSAyXe0kiheQLw5B/2gSPvFdEmpwFYbFXjzwsrKhaxRPF4gClNpWe+m1oLDKUOjkFbyDQD32J5hxH4nByxezGv/ZceoMmpA7jQFn2uHxHTqYcpvcQFw6u+9YMPhG/CWxpwjLFsKPlE4sUtgsympQ6wqSc7d8uOTH/EdPT7qwN362+nqeUrH087Vt7Ppg16tyNJRwkJ3Zqs4MUSyh5SlimGOIJxC7IAeCb3vKmG0GGr6qxH60M78/JHsVZk2kFdBoKuVbgAkHRfZFYh87M9S1jkqvqxUTx+fWX/dzPgFhkSW/k6UR1XUiTD11u/CCZZbcHiMyne38w7LE6420ENKw4sOVPSpA/dSraUo7m8oXIqDsItwBRwnub0JZ7Zf08VMcWVY1ZXz9zfeuO3YdelesPQqU4Yg/JJu6uakkuVLC0zpcIuxugEk7V63GC8vHCI+hEHTd+o8PNUng9bnGqW+R3YMw5EYjwE9bUh6CWUFOtElZZ61E1amW7R8maVXjBXHCs61Wut23YTkZ/jQkEVgYidnkoSCmdBJN1s9xtWOzQ0
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR10MB9645.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(23010399003)(366016)(10067099003)(56012099006)(11063799006)(4143699003)(261021135927099003)(261026140227099003)(261026135527099003)(261021133027099003)(261021121427099003)(261022113327099003)(261028144727099003)(261026121527099003)(261021130227099003)(261102123227099003)(261022115727099003)(261022105027099003)(261021123027099003)(261022075727099003)(261026130827099003)(261009223027099003)(55112099003)(6133799003)(22082099003)(18002099003)(4133799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?L1cyMitsUEp5Y3VYVW1LM1JsTUlZb082Z1B3cEIrMWh5Q056c3Z3ZENRWmlo?=
 =?utf-8?B?cGQ1cWNwd1RGY1B0V25YN084TFR6MHZkc0FvWjRHaFhVVHVSSXJOSHJNcWZv?=
 =?utf-8?B?WGNCSUxYK3FuRHFOa2M2K1hzTnVrRWdaUGpsWlVJcUdKUk9MeWdtMm9UOER2?=
 =?utf-8?B?REYwUERlVGgxd3lpVGp1bkhwcFRlRXArS3ovL05TYkhaR1VSUVhmdWQ5bmJ6?=
 =?utf-8?B?Mi90YTBrSnpZTFp1Sm5DUFpzczB1WWR3NXl2dDAvWnNheS9PSG5yK2txR210?=
 =?utf-8?B?K3BodEdvZGl4Z1JjSFNNRWNHYVl6VjM0Uys0bHJieEFWeC9qTkJReTc4NnpU?=
 =?utf-8?B?bEt1V3lnZHlNTkFiZ29tNU1vMWx1ZTFRcHJJM0ZNOVNFam94VDJIcmtIK2Z0?=
 =?utf-8?B?RHgwS3dSczRlNHNUVVh3L05SY0ZKc2p1T056M2VDcFZKdHpsMHRQUjZKQW94?=
 =?utf-8?B?UXREMFVWajVScUV5QW82Rmt4RStMVnVsVXIwRjZpVEwva3Ayd0RpekZwYk42?=
 =?utf-8?B?Z0RZa0lBOXoyUnQ5ek9hNW5JdFVzazZvcjlOYUJZMVN2ZzVOK2Z5N3ZWNkxX?=
 =?utf-8?B?ZjQ3Ry9PYW5ESXdsSnU2U2ZZZGtrT1dkTTdDZ2NkQVFNTThGVmNQL0lpb3U5?=
 =?utf-8?B?ZkQxdjhNSHM5VWNsYmRRNWFLNDN1SzlpNEZTU1lxUmhNNmVQNkROZkpDWHFP?=
 =?utf-8?B?cWk0MUdDWjNLbjZjNXNZN3VXMDBWZFFtTTlUSU1Sc0JXKzVtam11UnJkVlhH?=
 =?utf-8?B?VzFqTy8xcnBSZ0JFNHc5Y2EyQTZhRG9Oc0VuaHhkL3pnc3lvRVYzcVBWSWZz?=
 =?utf-8?B?T1NqSHBLWXRjN0k1MUQwRVZmVGUxV0tIMmE2NXM4QzQxMlc5QTJkMEJmbC9s?=
 =?utf-8?B?VlE2NTdsOStKNzhiWTlHUVhSSUg2MDdDQ2pwczF6elhZNGtKYWZBT3QxZ3pF?=
 =?utf-8?B?WlFEVlR1TGs4QUFIRS94Slppd2ZickxFVFA3UHJBQUJNZGZmVnRHd1EyRVFJ?=
 =?utf-8?B?Tkt0cHVKaldtRUdmRWlYT1hobnNLckFLakJDSlRkZS9DZ1R5UEtwd05mb2M0?=
 =?utf-8?B?MkNBR0tQcUZhTEthYTNOMGVwNnN2cVhKazA2ekk3TFBFTDBMNStMenh5Tmtr?=
 =?utf-8?B?eWh4Q3dDV1RFSjRxYVA2R3pFbnp2SGg5cWRpSkwrYTJYY091MTQvNGRBOGJP?=
 =?utf-8?B?VjNLZXJLdzdCbmpwblRPT0EzWDJ1Q1RyQW5WWnJDemZPbHBSVHJxQVZxVVFy?=
 =?utf-8?B?dXV0ZStKaklLUUwya2dycVluOCtubTJOUUsyOEwxSjR3bDhDVnpiZG5QUlIw?=
 =?utf-8?B?NkRqekpTQUgvVFpMZk1jcUIvMlRCVm04a1FmYm9MWTJNQ2pydG1BRHRsdjRC?=
 =?utf-8?B?V0hzaHdwQVNkQVFxMk5RMTJxVWYxaXFKeTNQdHdRL1ZzL3d6ZVp3Umtja3pW?=
 =?utf-8?B?WE05RWhNZzN2dWpvUkVIM3dNMmJRTzFIZUhLSTZWOVlWV0l1N00xR3lZcGpr?=
 =?utf-8?B?c20rY1g3clpYUTRPUGU5WGhvWWdyRExjS2VaSXVuZ0M1eHFqTzQ4VXZOYThJ?=
 =?utf-8?B?anVGVFlyUllFbVFrbjg3eHRUVjJkZ1RNa3JoZ1hXRGJwQlJoVmkvd0xvRElU?=
 =?utf-8?B?bElPYjFLVDVvY1RrRWEwZzVGdHZiYXlEY00ybXV0cXV0aXNlQTBGcS9FdFN6?=
 =?utf-8?B?WGdYZDcvOHV3MmsyVXJrMW5aTzdzamxyMGdqT2QySFFEcFhHbmxLd2NMOE82?=
 =?utf-8?B?aVk2S2NpeDN1TDF1VmFPUkhvY1hMWEJ2ZWdmNHZVK1FEU3AxWVp4ajRKbDJI?=
 =?utf-8?B?ZVFramw3VCtoY0ozVlM5dGVZNXhSeEJMWnovdEtmL0s2TG5hajBJQWxDcTVz?=
 =?utf-8?B?ekpLeUFxZm5XK2lXV0lxdm1rOUxTOEkxak9makNBdTBDKytxcWRicDQwdzMv?=
 =?utf-8?B?ZDY2dC9ITHRuTjRnbzVUUHFSYjZQNFhOc21xRDJSMWhaRzBXUC8ydUt4V3BN?=
 =?utf-8?B?LzQ4N2NUYlYyTzdENVRKL0NiZFVwMnpuWXVTY3JnSGFBUS8zbVpzWE9JTy9r?=
 =?utf-8?B?ZTZlZnB2UWo0V3dUZWNZVDNtdGtQZ1RmTThEamVHQzNYUXc1RVhMYWRydFYw?=
 =?utf-8?B?U3pKT2kwMjZEeWNBbEV6blFlRWk5ZlVsZ0YvUnorUFdwVURvU2NtYWFCb2lR?=
 =?utf-8?B?RlhocFo3NU8xSTU5a2xDRUdid2RqTU8vNElWWE1OK3NwRkUzWDBYWlNTQ0ZX?=
 =?utf-8?B?UEZIaGhrU2ZRWEJ1eXV4RVB4ZU84WlE5eWVRYi8zQUJ6MGJxNE5ZbzJEdmMz?=
 =?utf-8?B?NEpWTkdDZEJkdmRpSnVBWXR2Y1owMXFJU0RJc0VYREdraDFxOE5KbG5Xa3pQ?=
 =?utf-8?Q?nNnPpSaLB4ExNlUE=3D?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e41aef73-fa85-438f-06c9-08df496ebdd4
X-MS-Exchange-CrossTenant-AuthSource: AM0PR10MB9645.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Nov 2026 14:33:29.0587
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: abF4czIwUl9G/z0w6Q2meV94Pi5sdE4YLLy1AfJ/5j9yHXc0vMuGySGSTbPDl4XzV8Rhi0fJ3lJQOpPDGX3JrwQj7kdlzVcDvTE6gagOe+k=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR10MB3287
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by lin-tor-korg-lkml-alma10-1 with HTTPS for <cip-dev@lists.cip-project.org>; Mon, 23 Nov 2026 14:33:36 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/25049



On 11/18/26 13:59, Jan Kiszka wrote:
> On 18.11.26 13:54, Felix Moessbauer wrote:
>> We convert the wic plugins so that they support being executed via a
>> WIC_TOOL_RUNNER. This change has to happen in lockstep with the
>> corresponding isar update, as it is incompatible with the previous
>> execution model.
>>
>> Signed-off-by: Felix Moessbauer <felix.moessbauer@siemens.com>
>> ---
>> This patch has to be used on top of isar with
>> "[PATCH v2 0/6] Update BitBake in Isar" [1].
>>
>> The _tool_path_exists() method should be moved to wic.misc (in isar) so that
>> it can be reused by all wic plugins.
>>
>> [1] https://groups.google.com/g/isar-users/c/NYmzKbKTqH0/m/BTECiBRVAQAJ
>>
> 
> IOW, proper actual patch will once come with an Isar update and the
> changes below.
> 
> Jan
> 
I had a look at this and most changes in this patch are unneeded, e.g., 
the switching from exec_cmd to exec_native_cmd, as both use 
WIC_TOOL_RUNNER. The v3 series for updating BitBake in Isar [1] now 
contains tool_path_exists().
I have sent an updated version of this patch [2].

[1] https://groups.google.com/g/isar-users/c/NYmzKbKTqH0/m/la9-tg36AgAJ
[2] https://lists.cip-project.org/g/cip-dev/topic/122412147

Clara
