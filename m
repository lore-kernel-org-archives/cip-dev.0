Return-Path: <chris.paterson2@renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12CD0C04FFE
	for <webhook@archiver.kernel.org>; Tue, 14 May 2024 13:19:04 +0000 (UTC)
Received: from JPN01-TYC-obe.outbound.protection.outlook.com (JPN01-TYC-obe.outbound.protection.outlook.com [40.107.114.41])
 by mx.groups.io with SMTP id smtpd.web11.15290.1715692736949016829
 for <cip-dev@lists.cip-project.org>;
 Tue, 14 May 2024 06:18:57 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@renesas.com header.s=selector1 header.b=H/cEHn8G;
 spf=pass (domain: renesas.com, ip: 40.107.114.41, mailfrom: chris.paterson2@renesas.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UYIGgmYHbTNFHupsFtPoZuXi1g3+0RaawlLjqdeBJePW62R8Irj4MMdl4CRrCceg9h9rpS6Owx04JGTU0uTuiJi0rCe44c7XruCEUfLDE38iE/Hk7m2TZBtUpedrV70vua2Qe3fZu6fM+orgcLg+rFmjPEn2BQA+LYsEnfXzSVavR8UWjdG+v7WFGxjfqqvHk6EL4xF83ZhZHMslbZLZugE935rXlt/3E4Jvs3MeV7dDpDARjbw7UgeQitbonSW/tRQ1Tjv6w+R/S6FEu7EHuWgQrnorfMZuIL9Cfc4IbElfN6po2P9Nok4EWsz/ZVngIKxVtlXoVYneyBujxb+BeA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YSy/brysGiPNh+vgvkWDwwYj5PR+vrra9WE4tYlU5GY=;
 b=ec8p/oFP7VtQaQquSJ48tQNxzQnUHAMAulBIMATTN+ABxy1TLHDwco/eH6vCIngnOBnoVq9lhAxtH0AL8n+yTYW6adiC47x8HI2zNBfw/1LXCHo5l1GeYZ1K3TwI0aFlh0uR3a2mJhoCLMiIPlQoMxKrg6nFFI9rJG5AEuGjLiDkRifYwLAQeeMfxSOrQ8uhW8/JvwJBXIbh2aCvk4zoA6sLRaZWZgsp5WogFmSD78SwKtY/fkb1M1sJVzGsiKcH3m9LR//bwFz9UMvyGCmy52p+Lojf5Pb3NvMziqnMkkq/y+hAq5h+7dvWkIuWEdRkcFMrYvRpRlYbhVBEhnszEQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=renesas.com; dmarc=pass action=none header.from=renesas.com;
 dkim=pass header.d=renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YSy/brysGiPNh+vgvkWDwwYj5PR+vrra9WE4tYlU5GY=;
 b=H/cEHn8G9hW63COiqe1tXPYOFuNkLhpslBWdQnbYndAFTyq37bI8wtFSWaeQda9sGFIs08lY84E3fvPo2Z+8PQdZLTsXjn2zvCIbEku+tR+qp0aFTKxhlb2R8M5sT+MbEnrNb2ojzwzH7DTpIjEWAL1nlzfup79muk8S5juTS8g=
Received: from TYWPR01MB11862.jpnprd01.prod.outlook.com (2603:1096:400:3fc::6)
 by OS0PR01MB6130.jpnprd01.prod.outlook.com (2603:1096:604:cb::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7587.27; Tue, 14 May
 2024 13:18:51 +0000
Received: from TYWPR01MB11862.jpnprd01.prod.outlook.com
 ([fe80::fbad:9a9e:9e5:7cfa]) by TYWPR01MB11862.jpnprd01.prod.outlook.com
 ([fe80::fbad:9a9e:9e5:7cfa%6]) with mapi id 15.20.7544.052; Tue, 14 May 2024
 13:18:51 +0000
From: Chris Paterson <Chris.Paterson2@renesas.com>
To: "Sai.Sathujoda@toshiba-tsip.com" <Sai.Sathujoda@toshiba-tsip.com>
CC: "cip-dev@lists.cip-project.org" <cip-dev@lists.cip-project.org>,
	"dinesh.kumar@toshiba-tsip.com" <dinesh.kumar@toshiba-tsip.com>
Subject: RE: Query regarding SQUAD watch job submission
Thread-Topic: Query regarding SQUAD watch job submission
Thread-Index: Adqciz/XU7pqriezQs2bbbOHPjbwrwFpC16QAPRlDgA=
Date: Tue, 14 May 2024 13:18:51 +0000
Message-ID: 
 <TYWPR01MB1186205A8C7B706EA3BD3E664B7E32@TYWPR01MB11862.jpnprd01.prod.outlook.com>
References: 
 <OS0PR01MB6100BB4B8D14EC6E9527AD68C2182@OS0PR01MB6100.jpnprd01.prod.outlook.com>
 <OS3PR01MB61038D732173B9974298157EC2E62@OS3PR01MB6103.jpnprd01.prod.outlook.com>
In-Reply-To: 
 <OS3PR01MB61038D732173B9974298157EC2E62@OS3PR01MB6103.jpnprd01.prod.outlook.com>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYWPR01MB11862:EE_|OS0PR01MB6130:EE_
x-ms-office365-filtering-correlation-id: fe4d4dba-9cc6-4294-f5ff-08dc741865dc
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230031|1800799015|376005|366007|38070700009;
x-microsoft-antispam-message-info: 
 =?ks_c_5601-1987?B?VXpJMldLNXBmaTU2bGlJb1NqeWpGV0Z4T0FBOUQwb0N2QlpIUjA4?=
 =?ks_c_5601-1987?B?cVVmczdrLzVGeDVuU0JtOWZKK2NtL0ozVUdJWHZqYWh5QVAwUGlo?=
 =?ks_c_5601-1987?B?VS9GaENEVENMWVF0Y2FiMVpqeFM5MThIMDNmakhTQlRGTThqTjdz?=
 =?ks_c_5601-1987?B?emQ4Nk0xWmtIZENyR2FtKzZpM0g3YzM3R1VPWXhhV1ZZa0xXWHRp?=
 =?ks_c_5601-1987?B?NkVUQlZCT1E1cVI0YmFkRFBkd0FTZjN6cjVtYVg2YlloUzdSOGJG?=
 =?ks_c_5601-1987?B?c1JHbkRFYXBidFN3WWllR3U4c2RNSlhMdW1oME1DOUNVNmpRSHdT?=
 =?ks_c_5601-1987?B?ZG5ZcFZOMld4QzcxR2VjVDRGTTJJWmFmOCswT1ZTaWRTK1Jrbndu?=
 =?ks_c_5601-1987?B?ekRwcFAxb21UR0dQUlYrUGNPZWZDZWVNT2JzUTE0MzNkS21NdjNn?=
 =?ks_c_5601-1987?B?TzJvMy9hZXNYRVdyTWpBUTBHTzdlZWlMaGx3SkVFTUM2ajRWNkRM?=
 =?ks_c_5601-1987?B?RmZwaU5oaGE0U3F6NE0vWFF0aWlNNTFydjk1ZmhFK2x0Q09ibi91?=
 =?ks_c_5601-1987?B?MlBuZWhNajFBL2pHT3k3UU9tVDJUTzNpNlBMeGJjTnhsUUVJS2Za?=
 =?ks_c_5601-1987?B?MWxxY3JlM2l2Qlc2SHFzNGFYUE15eDZ1bUU4Yk9Dd2U1a0o0Z1di?=
 =?ks_c_5601-1987?B?REtuZXlhOXMycUQ4eE5kUEYrRnpvUERNNXJUZ2NXN1FkbzhvT1o3?=
 =?ks_c_5601-1987?B?dENTVWIvU3RLaDY2bCt2UEJFbE1yUkJMaDY5amliMjJRcmlYTUli?=
 =?ks_c_5601-1987?B?TnBCK0lDenNKditFamRWT3IvY243c3NURXovNEIyMkYzQ0dUSDQv?=
 =?ks_c_5601-1987?B?K2kza1FibUMyUERQK2N4V25jM2Fpd01RcnR5TW1NWjBBQ091MkFa?=
 =?ks_c_5601-1987?B?QnRJekY5TENkUFplMFNzemw3ZWVUamxhR3NLNmhqamVjZFFnTmx5?=
 =?ks_c_5601-1987?B?enpnSU9oOGtZaWk1MkhDaTdpVDA5cDV4M2MzdTVaVEx0ZkZvbVBW?=
 =?ks_c_5601-1987?B?aHVzcS9aMDNVNTd1UnY3TmZ1OG1kbDVCRms3bXV3WXQzdkhqU1Nx?=
 =?ks_c_5601-1987?B?aU9EUG1Ga3VncnQzcytKNUFWNlUvVmNoWU9zK01vUjVYdjBobWov?=
 =?ks_c_5601-1987?B?aEFtZS96MUZRb2hORkZIbythdTFnaFA5TlhYSEVkUmNVVGE2eE9N?=
 =?ks_c_5601-1987?B?SkVqMFFGRjBhM0FLSit2bkpiSGZ4MUUwckZhVlQrTXAvYm1sejl2?=
 =?ks_c_5601-1987?B?Y1JyRXJweUpqK3hGdTFMZHlMUUpObFhQMDZrSFpBTGJiWjJqL0Vx?=
 =?ks_c_5601-1987?B?ZjVLcFdvV05NNWtqNEM2NTBNRW1wNEFWZ3RaVjBsaTdqeDg0Mnla?=
 =?ks_c_5601-1987?B?RGMvWWoyWDg4VzJ1ZmdTdHN1WndFR0xZQXUwUTU0a0hBTk0xNTVV?=
 =?ks_c_5601-1987?B?UytmQnlBanJvQ1FTR21JRnFjc21oMUUyUllWSUEvREpZYW50c0Vn?=
 =?ks_c_5601-1987?B?R0tmRGNNaU9lYUVrTGZNNWRmVThxdTYrUXZvQUlpT2xwcDlhakgv?=
 =?ks_c_5601-1987?B?ZE1SU2g4cGZYZ0dWRHFOak50YW96OVV3OHlXUTI3UmV6bnpHdS8r?=
 =?ks_c_5601-1987?B?ZExGeWZIaWVUbFcxeFQvdTNQV01ZVU9jUTJod2oxdGFOeHV0Z3c2?=
 =?ks_c_5601-1987?B?TjRVdWFycENIRi9MZWIyeElsS1NseURuS1BCV1VQelBZTU5wT1pu?=
 =?ks_c_5601-1987?B?TjlLWUgrUFJIdWJNd1diYTRRaFFWUUFwQ0hzQVVGOFNRZGtxbzJJ?=
 =?ks_c_5601-1987?B?TEVBMm0rSDF2ampuVWNzaVdwemJGU0RQdSs2Sm5ETlM2RFc3aldz?=
 =?ks_c_5601-1987?B?NHJVV1JkcVNjT2UvUFJEMGxsTGpJMDIrb0c5MDVPTzVBbDZzTFlB?=
 =?ks_c_5601-1987?Q?7vf04Id7LJ6faE6vlF/LaW9nL3ASCxx+RlA8=3D?=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:ko;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYWPR01MB11862.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(376005)(366007)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?ks_c_5601-1987?B?ZnpybWNIeS91cFR5TkpubVB3UnpnNmtTMWE0ckpoZ0ZVVCtzc1c5?=
 =?ks_c_5601-1987?B?QkllcDRvWWhEK1hmdnpTOXJxOEhaeXJvK0VIdDduZ0hqZjIrQ0xV?=
 =?ks_c_5601-1987?B?bHArSXdUbTNlMUVsOXJXNHRLT0xRYUxseDJoM2UyZEl1dllVdVVV?=
 =?ks_c_5601-1987?B?VlZHeUhndHovUTRyU2pGbXdienFjMm5qbGZLSjBvcWhsaStMYmlL?=
 =?ks_c_5601-1987?B?VTRCZVI1UjNZb1VvKzgrclczR05kcEVjeTZ5NEE1M1hsVWJMRk5t?=
 =?ks_c_5601-1987?B?T0RTQ1dQT3ZjeENLVXVOQTBQbzNGSnE3YWx2bmx6M3RrQkJhd216?=
 =?ks_c_5601-1987?B?NUFZR1lrUGNLN2N0RVZYOElMM2hGU3didVAvWlBPMEtDeXBFNDZj?=
 =?ks_c_5601-1987?B?NElPNWl5UHBCQ1MvbUFFREloL0VMYUpvSTIydGdrUUNEeDFTU3Np?=
 =?ks_c_5601-1987?B?cWZzYW53d3YvRk8wVUluZjVNSlN4eXlwWGt4SU9DbUlFb2xGWlpy?=
 =?ks_c_5601-1987?B?SnY1T1VzVkQ3V2I1SjBMUm4yLzJ4eS93WjByZDZxdy9FZkh2ZzhK?=
 =?ks_c_5601-1987?B?bC9mQ1FIV2NPQThxbExHWGhGbllwQ2VZY1d0WENpWWZoakFYdlZY?=
 =?ks_c_5601-1987?B?aWsrVS9ROHNXRkY4LzBJQnU0S2MydDBzMC9mZXdSSTZqdnBLYndF?=
 =?ks_c_5601-1987?B?dkJPTkxaY1BZRlRnakQ4OGFzSGlGcXIveFVJb1hlSEFoNUcrNSts?=
 =?ks_c_5601-1987?B?bks2MFZPOURTQzFiRXNobjh3NWJDMno3MTk5amhlcmJYS2psYS9k?=
 =?ks_c_5601-1987?B?WTBUTUNvQmdrQ3B2WUVnbk9nczV3cXFkNGJMenVGb09nVUR2QVo2?=
 =?ks_c_5601-1987?B?c3FJT0ZUU00yM2d3dUZtYUZ5UEdCQ0ovaVhJd1N1T1h6Q0ZOZHBB?=
 =?ks_c_5601-1987?B?TUZWYjArazJ0R2kwKzRUc0R1OFl3b2N6ZFdMd3hUY25pV2JWcjZN?=
 =?ks_c_5601-1987?B?V2MwT01tcm5tcGx6bzhCeHZKWm8wV2U0bHgvSFkyZlB0KzhObjdN?=
 =?ks_c_5601-1987?B?K3ZPcGJLMks2R21Ga3lBYVk4bGpYNUJ0ai9sUUFEOXBvYTdkbW9O?=
 =?ks_c_5601-1987?B?WTl4ako0WXJqU0gzQVcxWm9mWjRvUlYyNHR3WlAxUnFHb3hwVnJC?=
 =?ks_c_5601-1987?B?eFJaSUVqcllOR0VhM2tVdy91enlyT3hMdjdobngwTEdpOHNMT1Jv?=
 =?ks_c_5601-1987?B?TTZPbGdPanUyWThESlBEY1RtRUJLNUdDL2pnS09xTlpTR0NHWVU0?=
 =?ks_c_5601-1987?B?aVNXSmFQWVBSTUlHcDFyM1VQbURtcWt5WmtYeVU0RE9QTnhGSklV?=
 =?ks_c_5601-1987?B?UzRBeUNZTTBqMGJVUitPSkJkR2hVK25MMXRRRncvNHd5YjV4K1BB?=
 =?ks_c_5601-1987?B?TVpNbWErRngyZ1htUG9wQ2pwam8yT05VaFdIZlppZGE5cTg5K0pt?=
 =?ks_c_5601-1987?B?TSswRjhpWTJhbjBIOCtoUTJDTSt0SUpYU3J4VjdFT1BQTU9vWFFP?=
 =?ks_c_5601-1987?B?aXY2QUFQZUVQYWtnM1dhOFRJazJUZDJ1aktTUitJOXB3WFBKYzR5?=
 =?ks_c_5601-1987?B?ZUc2ZVJJVTNFOFY3M3BlaG5JMmJPRmk5dVVzMk1nalc2N0Q4cVFG?=
 =?ks_c_5601-1987?B?MnFWZlo4RHNXNnBrRkZsZ09FNzFPQW05SnNRcnVaaVJjWmxGL0pN?=
 =?ks_c_5601-1987?B?MlJNbHpmc1BMc0xUYnRRaTMrOWIwb1pzWnBuamFpdExlbHRSSFor?=
 =?ks_c_5601-1987?B?NkN6M3hiVkNQTldlUXlVMDJpaTdQRVRsWktWd2N6d2FabjFKQ3BU?=
 =?ks_c_5601-1987?B?MGhkbkhDbjZiL0pqY2ZBNGwyam95emtOOE1RanNhL3BreHBwUXpY?=
 =?ks_c_5601-1987?B?MHhBZEtid3VJSXVTR1FBb2Z2ZG83Q2tTUUh3STQxZmhJSTF2V0xU?=
 =?ks_c_5601-1987?B?b1BibjBZNDlRRTFoMmVhNkpDb2hyblFTekZyZDVtY1VMSVp2K25n?=
 =?ks_c_5601-1987?B?NnU1aEZkdlVNU3ZLQklhNHZSKzRkdHcydGlUVWsvN0lmVGN3Y3pO?=
 =?ks_c_5601-1987?B?ajlQZ3JZK2lyMENHK0JIRjJSQTM1aVpQbm4rbXltMm03dGlEdFd6?=
 =?ks_c_5601-1987?B?cTJPb3l2M2hsOXo3MjZkS1ZCbFMwUkF2WXlEZS9JcVpMTzB0NTJm?=
 =?ks_c_5601-1987?B?QmJSc3RoaUd1MEcvUEtBVTN4b3VHV2hUQVpXQzlObnRVZC9DOTZv?=
 =?ks_c_5601-1987?B?YmVubHVsU005THFwOVVoQTJtdzY5cUVkL0xQWDhvZFljbWdLb3ht?=
 =?ks_c_5601-1987?B?M2VSeElyUHhkY2tvejh6WDRKc0Z0eEpSZVBBQ1laZzQ4a2k2b2ZB?=
 =?ks_c_5601-1987?B?Y0F2cDUyZUdPU0dNQWMvQTltSVVxWU9nSDF5U0NYc25yQkgvQy8w?=
 =?ks_c_5601-1987?B?QlNCbmlHbGFVQXgybk9ZZ1V6R0JScFE9PQ==?=
Content-Type: multipart/alternative;
	boundary="_000_TYWPR01MB1186205A8C7B706EA3BD3E664B7E32TYWPR01MB11862jp_"
MIME-Version: 1.0
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYWPR01MB11862.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fe4d4dba-9cc6-4294-f5ff-08dc741865dc
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 May 2024 13:18:51.6666
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 7c01hKKQ5nONzfQ+Y4fUBkbFU3S3osHQnSMjqq+743FYA76w01lXcA+zLRWDqAHnOgDWUh9poGNheYKVMKJRW4Pse+hdAhJ9TBUgojkdBkU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS0PR01MB6130
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 14 May 2024 13:19:04 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/15891

--_000_TYWPR01MB1186205A8C7B706EA3BD3E664B7E32TYWPR01MB11862jp_
Content-Type: text/plain; charset="ks_c_5601-1987"
Content-Transfer-Encoding: base64

SGVsbG8gU2FpLA0KDQpJoa92ZSBjcmVhdGVkIGEgbmV3IGdyb3VwIGFuZCB0aGUgcHJvamVjdHMg
eW91oa92ZSBhc2tlZCBmb3I6IGh0dHBzOi8vc3F1YWQuY2lwbGF0Zm9ybS5vcmcvY2lwLWNvcmUv
DQpJoa92ZSBhbHNvIGNyZWF0ZWQgYSB1c2VyIGZvciB5b3UuIEmhr2xsIGVtYWlsIHRoZSBkZXRh
aWxzIHNlcGFyYXRlbHkuDQpZb3Whr2xsIGJlIGFibGUgdG8gbG9nIGluIGFuZCB2aWV3IHlvdXIg
dG9rZW4gaGVyZTogaHR0cHM6Ly9zcXVhZC5jaXBsYXRmb3JtLm9yZy9fL3NldHRpbmdzL2FwaS10
b2tlbi8NCg0KS2luZCByZWdhcmRzLCBDaHJpcw0KDQpGcm9tOiBTYWkuU2F0aHVqb2RhQHRvc2hp
YmEtdHNpcC5jb20gPFNhaS5TYXRodWpvZGFAdG9zaGliYS10c2lwLmNvbT4NClNlbnQ6IFRodXJz
ZGF5LCBNYXkgOSwgMjAyNCA2OjI1IFBNDQpUbzogQ2hyaXMgUGF0ZXJzb24gPENocmlzLlBhdGVy
c29uMkByZW5lc2FzLmNvbT4NCkNjOiBTaWV0emUudmFuQnV1cmVuQGRlLmJvc2NoLmNvbTsgY2lw
LWRldkBsaXN0cy5jaXAtcHJvamVjdC5vcmc7IGRpbmVzaC5rdW1hckB0b3NoaWJhLXRzaXAuY29t
DQpTdWJqZWN0OiBSRTogUXVlcnkgcmVnYXJkaW5nIFNRVUFEIHdhdGNoIGpvYiBzdWJtaXNzaW9u
DQoNCkhlbGxvIENocmlzLA0KDQpIb3BlIHlvdSBhcmUgZG9pbmcgd2VsbC4NCg0KVGhlIGlzc3Vl
IEkgbWVudGlvbmVkIGluIHRoZSBwcmV2aW91cyBtYWlsIGluIHRoaXMgdGhyZWFkIGlzIHJlc29s
dmVkIG5vdyBzbyBwbGVhc2UgaWdub3JlIHRoYXQgcXVlcnkgaWYgeW91IGhhdmUgbm90IGdvbmUg
dGhyb3VnaCB5ZXQuDQoNCkFzIG1lbnRpb25lZCBlYXJsaWVyIHdlIGFyZSBwbGFubmluZyB0byBh
ZGQgQ0lQLUNvcmUgTEFWQSB0ZXN0IHJlc3VsdHMgaW4gQ0lQIFNRVUFELiBJdCB3aWxsIGJlIG9m
IGdyZWF0IGhlbHAgdG8gdXMgaWYgeW91IHByb3ZpZGUgeW91ciBzdXBwb3J0IGluIHRoaXMuDQoN
CkNhbiB5b3UgcGxlYXNlIGNyZWF0ZSBhIGdyb3VwIG5hbWVkIKGwbGludXgtY2lwLWNvcmWhsSwg
dGhyZWUgcHJvamVjdHMgbmFtZWQgobBTd3VwZGF0ZS10ZXN0aW5nobEsIKGwU2VjdXJlIGJvb3Qg
dGVzdGluZ6GxIGFuZCChsElFQyBMYXllciB0ZXN0aW5nobEgdW5kZXIgdGhhdCBncm91cCA/DQoN
CkN1cnJlbnRseSBJIGJlbGlldmUgdGhhdCByZXN1bHRzIHByZXNlbnQgdW5kZXIgdmFyaW91cyBw
cm9qZWN0cyBpbiChsGxpbnV4LWNpcKGxIGFuZCChsGxpbnV4LXN0YWJsZS1yY6GxIHdpbGwgbm90
IGJlIGRpc3R1cmJlZCB3aGlsZSB3ZSBleHBlcmltZW50IGluIGFkZGluZyBDSVAgQ29yZSBMQVZB
IHJlc3VsdHMgaW4gdGhlIHByb2plY3RzIHVuZGVyIKGwbGludXgtY2lwLWNvcmWhsSBncm91cC4g
UGxlYXNlIGNvcnJlY3QgbWUgaWYgSSBhbSB3cm9uZyBhYm91dCB0aGlzLg0KDQpXZSBhbHNvIG5l
ZWQgYSB1c2VyIGNyZWF0ZWQgaW4gQ0lQIFNRVUFEIHdpdGggYSBTUVVBRCB0b2tlbiBhc3NpZ25l
ZCB0bywgc28gdGhhdCB3ZSBjYW4gc3RhcnQgbW9kaWZ5aW5nIHRoaXMgc2NyaXB0IGxhdmEuc2gg
oaQgbWFzdGVyIKGkIGNpcC1wbGF5Z3JvdW5kIC8gY2lwLWNvcmUtY2kgoaQgR2l0TGFiPGh0dHBz
Oi8vZ2l0bGFiLmNvbS9jaXAtcGxheWdyb3VuZC9jaXAtY29yZS1jaS8tL2Jsb2IvbWFzdGVyL2xh
dmEuc2g/cmVmX3R5cGU9aGVhZHM+IHRvIGV4cGVyaW1lbnQgb24gaG9zdGluZyBDSVAgQ29yZSBM
QVZBIHJlc3VsdHMgb24gU1FVQUQuDQoNCkNocmlzLCBJIHJlcXVlc3QgeW91IHRvIGFkZCB0aGUg
bWVudGlvbmVkIGl0ZW1zIHRvIENJUCBTUVVBRCB3aGljaCB3aWxsIGhlbHAgdXMgdG8gc3RhcnQg
dGhpcyB0YXNrIGFzIHNvb24gYXMgcG9zc2libGUuDQoNCklmIHRoZXJlIGFyZSBhbnkgaXNzdWVz
IHdpdGggZG9pbmcgdGhlc2UgY2hhbmdlcyB0byBjdXJyZW50IENJUCBTUVVBRCwgcGxlYXNlIGxl
dCBtZSBrbm93Lg0KDQpOb3RlOiBJZiBhbnlvbmUgaGFzIGFueSBjb25jZXJucyBhYm91dCB0aGUg
Z3JvdXAgYW5kIHByb2plY3QgbmFtZXMgcHJvcG9zZWQgYWJvdmUsIHBsZWFzZSByZXBseSB0byB0
aGlzIGVtYWlsLg0KDQpUaGFua3MgYW5kIHJlZ2FyZHMsDQpTYWkgQXNocml0aCBTYXRodWpvZGEg
KFQgUyBJIFApDQoNCg0KDQpGcm9tOiBhc2hyaXRoIHNhaSij1KPTo8mj0CkNClNlbnQ6IEZyaWRh
eSwgTWF5IDMsIDIwMjQgMTI6NTMgQU0NClRvOiBDaHJpcyBQYXRlcnNvbiA8Q2hyaXMuUGF0ZXJz
b24yQHJlbmVzYXMuY29tPG1haWx0bzpDaHJpcy5QYXRlcnNvbjJAcmVuZXNhcy5jb20+Pg0KQ2M6
IFNpZXR6ZS52YW5CdXVyZW5AZGUuYm9zY2guY29tPG1haWx0bzpTaWV0emUudmFuQnV1cmVuQGRl
LmJvc2NoLmNvbT47IGNpcC1kZXZAbGlzdHMuY2lwLXByb2plY3Qub3JnPG1haWx0bzpjaXAtZGV2
QGxpc3RzLmNpcC1wcm9qZWN0Lm9yZz4NClN1YmplY3Q6IFF1ZXJ5IHJlZ2FyZGluZyBTUVVBRCB3
YXRjaCBqb2Igc3VibWlzc2lvbg0KDQpIaSBDaHJpcywNCg0KSG9wZSB5b3UgYXJlIGRvaW5nIHdl
bGwuDQoNCldlIGFyZSBwbGFubmluZyB0byBwb3N0IENJUCBDb3JlIExBVkEgdGVzdGluZyByZXN1
bHRzIG9uIENJUCBTUVVBRCBpbnN0YW5jZS4gU28gSSBhbSB0cnlpbmcgdG8gc2V0dXAgYSBsb2Nh
bCBTUVVBRCBpbnN0YW5jZSBhbmQgaW50ZWdyYXRlIGl0IHdpdGggbXkgbG9jYWwgTEFWQSBMYWIg
c28gdGhhdCBJIGNhbiB1bmRlcnN0YW5kIHRoZSB0cmFjZWFiaWxpdHkgYmV0d2VlbiBjaGFuZ2Vz
IHJlcXVpcmVkIGluIGh0dHBzOi8vZ2l0bGFiLmNvbS9jaXAtcGxheWdyb3VuZC9jaXAtY29yZS1j
aS8tL2Jsb2IvbWFzdGVyL2xhdmEuc2g/cmVmX3R5cGU9aGVhZHMgYW5kIHJlc3VsdHMgZGlzcGxh
eWVkIG9uIHRoZSBkYXNoYm9hcmQuDQoNCkkgZm9sbG93ZWQgdGhlIGJlbG93IG1lbnRpb25lZCBz
dGVwczoNCg0KDQogIDEuICBJIHN0YXJ0ZWQgdGhlIHNlcnZlciBsb2NhbGx5IGFmdGVyIGZvbGxv
d2luZyB0aGUgc3RlcHMgbWVudGlvbmVkIGluIHRoaXMgUkVBRE1FIGZpbGUgc3F1YWQvZG9jL3F1
aWNrc3RhcnQucnN0IGF0IG1hc3RlciChpCBMaW5hcm8vc3F1YWQgoaQgR2l0SHViPGh0dHBzOi8v
Z2l0aHViLmNvbS9MaW5hcm8vc3F1YWQvYmxvYi9tYXN0ZXIvZG9jL3F1aWNrc3RhcnQucnN0PiAu
DQogIDIuICBBZnRlciB0aGUgc2VydmVyIHN0YXJ0ZWQsIEkgd2FzIGFibGUgdG8gYWNjZXNzIHdl
YiBVSSBhdCBsb2NhbGhvc3Q6ODAwMC4NCiAgMy4gIEkgZm9sbG93ZWQgdGhlIHN0ZXBzIG1lbnRp
b25lZCBpbiBodHRwczovL2dpdGh1Yi5jb20vTGluYXJvL3NxdWFkL2Jsb2IvbWFzdGVyL2RvYy9s
YXZhX3VzZWNhc2UucnN0I2NyZWF0aW5nLWEtYmFja2VuZC1mb3ItYS1sYXZhLWluc3RhbmNlIHRv
ICBjcmVhdGUgYmFja2VuZCBmb3IgbXkgTEFWQSBpbnN0YW5jZS4NCiAgNC4gIEkgY3JlYXRlZCBh
IGZyZXNoIHRva2VuIGluIEFQSSAtPiBBdXRoZW50aWNhdGlvbiB0b2tlbiBpbiBteSBsb2NhbCBM
QVZBIExhYiBhbmQgSSBhZGRlZCB0aGF0IHRva2VuIHdoaWxlIGNyZWF0aW5nIHRoZSBTUVVBRCBi
YWNrZW5kLg0KICA1LiAgSSBjcmVhdGVkIGEgU1FVQUQgdG9rZW4gYmFzZWQgb24gbXkgU1FVQUQg
dXNlcm5hbWUgYW5kIEkgcmVmZXJlbmNlZCB0aGF0IHRva2VuIGFzIHZhbHVlIHRvIEF1dGhvcml6
YXRpb24gdG9rZW46IHdoaWxlIHVzaW5nIFNRVUFEIHdhdGNoIGpvYiBBUEkuDQogIDYuICBJIGFk
ZGVkIG15IExBVkEgdXNlcm5hbWUgaW4gdGhlIHVzZXJuYW1lIHNlY3Rpb24gd2hpbGUgY3JlYXRp
bmcgdGhlIGJhY2tlbmQuDQogIDcuICBJIGNyZWF0ZWQgYSBzYW1wbGUgZ3JvdXAgaW4gdGhlIGFk
bWluaXN0cmF0aW9uIHBhZ2UsIGFuZCBJIHNlbGVjdGVkIHRoYXQgZ3JvdXAgc2x1ZyB3aGlsZSBj
cmVhdGluZyBhIHByb2plY3QgaW4gYWRtaW5pc3RyYXRpb24gcGFnZS4NCg0KQWZ0ZXIgSSBnYXRo
ZXJlZCBhbGwgdGhlc2UgZGV0YWlscywgSSBtb2RpZmllZCBzdWJtaXRfam9icyBzY3JpcHQgdG8g
dGVzdCB3aGV0aGVyIEkgY2FuIGF0dGFjaCBhIFNRVUFEIHdhdGNoIGpvYiB0byBhIGp1c3Qtc3Vi
bWl0dGVkIExBVkEgam9iIGJhc2VkIG9uIGl0oa9zIGpvYiBJRC4NCg0KQWZ0ZXIgSSBzdWJtaXQg
bXkgam9iIHRvIExBVkEsIEkgYW0gaW1tZWRpYXRlbHkgY2FsbGluZyB0aGUgd2F0Y2ggam9iIEFQ
SSB0byBhdHRhY2ggYSB3YXRjaCBqb2IgdG8gdGhlIHN1Ym1pdHRlZCBMQVZBIGpvYi4gQnV0IEkg
YW0gZ2V0dGluZyB0aGUgYmVsb3cgbWVudGlvbmVkIGVycm9yIG1lc3NhZ2UuDQoNCiQgLi9sb2Nh
bF9sYXZhLnNoDQovdG1wL3RtcC5GSkdHQmN4ek5uL0lFQ19hbWQ2NC55bWwgaXMgYSB2YWxpZCBk
ZWZpbml0aW9uDQpUaGVyZSBhcmUgY3VycmVudGx5IDEgInFlbXUiIGRldmljZXMgb25saW5lLg0K
U3VibWl0dGluZyAvdG1wL3RtcC5GSkdHQmN4ek5uL0lFQ19hbWQ2NC55bWwgdG8gTEFWQSBtYXN0
ZXIuLi4NCkpvYiBzdWJtaXR0ZWQgc3VjY2Vzc2Z1bGx5IGFzICM2MzQuDQogICUgVG90YWwgICAg
JSBSZWNlaXZlZCAlIFhmZXJkICBBdmVyYWdlIFNwZWVkICAgVGltZSAgICBUaW1lICAgICBUaW1l
ICBDdXJyZW50DQogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBEbG9hZCAgVXBsb2Fk
ICAgVG90YWwgICBTcGVudCAgICBMZWZ0ICBTcGVlZA0KMTAwICAgMzE1ICAxMDAgICAgNTYgIDEw
MCAgIDI1OSAgIDkzMzMgIDQzMTY2IC0tOi0tOi0tIC0tOi0tOi0tIC0tOi0tOi0tIDUyNTAwDQpT
b21ldGhpbmcgd2VudCB3cm9uZyB3aXRoIFNRVUFEIHdhdGNoIGpvYiBzdWJtaXNzaW9uLiBTUVVB
RCByZXR1cm5lZDoNCnsiZGV0YWlsIjogIlVzZXIgbmVlZHMgcGVybWlzc2lvbiB0byBzdWJtaXQg
dGVzdCBqb2JzLiJ9DQpTUVVBRCBVUkw6IGh0dHA6Ly8xMjcuMC4wLjE6ODAwMC9hcGkvc3VibWl0
am9iL3RzaXBfc3F1YWQvY2lwLWNvcmUtdGVzdGluZy8yLjAvbG9jYWxfZW52DQpTUVVBRCBCYWNr
ZW5kOiBsYXZhYmFja2VuZC5vcmcNCkxBVkEgSm9iIElkOiA2MzQNCg0KSSBhbSBhdHRhY2hpbmcg
bXkgc2NyaXB0IHRvIHRoaXMgZW1haWwgd2hpY2ggY2FuIG1ha2UgaXQgZWFzaWVyIGZvciB5b3Ug
dG8gcG9pbnQgbXkgbWlzdGFrZXMuIE5vIGlzc3VlcyByZWdhcmRpbmcgdGhlIGV4cG9zZWQgdG9r
ZW4gSSBhbSB1c2luZyBpbiB0aGUgc2NyaXB0IHNpbmNlIHRoaXMgaXMgYSBsb2NhbCBzZXR1cCBk
b25lIGZvciBteSB1bmRlcnN0YW5kaW5nLiBQbGVhc2UgaGF2ZSBhIGxvb2sgYXQgbGluZXMgMTct
MjIgYW5kIDEwNy0xMzcgd2hpY2ggY29udGFpbiBjaGFuZ2VzIG1hZGUgdG8gY2FsbCBTUVVBRCB3
YXRjaCBqb2IgQVBJLg0KDQpJIHdpbGwgYWxzbyBhdHRhY2ggc2NyZWVuc2hvdHMgZm9yIGdyb3Vw
LCBwcm9qZWN0IGFuZCBiYWNrZW5kIHBhZ2UgaW4gbXkgU1FVQUQgYWRtaW4gc2VjdGlvbiB3aGlj
aCBtaWdodCBiZSBoZWxwZnVsIHRvIHBvaW50IG91dCBpZiBJIHBhc3NlZCB3cm9uZyBkYXRhIHRv
IFNRVUFEIHdhdGNoIGpvYiBBUEkgY2FsbC4NCg0KUGxlYXNlIGhhdmUgYSBsb29rIGF0IHRoaXMg
ZGF0YSBhbmQga2luZGx5IHByb3ZpZGUgeW91ciBzdWdnZXN0aW9ucyB3aGljaCBjYW4gaGVscCBt
ZSBmaXggdGhpcyBwcm9ibGVtLg0KDQpUaGFua3MgYW5kIHJlZ2FyZHMsDQpTYWkgQXNocml0aCBT
YXRodWpvZGEgKFQgUyBJIFApDQoNCg0KDQoNCg0KDQo=

--_000_TYWPR01MB1186205A8C7B706EA3BD3E664B7E32TYWPR01MB11862jp_
Content-Type: text/html; charset="ks_c_5601-1987"
Content-Transfer-Encoding: quoted-printable

<html xmlns:v=3D"urn:schemas-microsoft-com:vml" xmlns:o=3D"urn:schemas-micr=
osoft-com:office:office" xmlns:w=3D"urn:schemas-microsoft-com:office:word" =
xmlns:m=3D"http://schemas.microsoft.com/office/2004/12/omml" xmlns=3D"http:=
//www.w3.org/TR/REC-html40">
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Dks_c_5601=
-1987">
<meta name=3D"Generator" content=3D"Microsoft Word 15 (filtered medium)">
<style><!--
/* Font Definitions */
@font-face
	{font-family:Gulim;
	panose-1:2 11 6 0 0 1 1 1 1 1;}
@font-face
	{font-family:"Cambria Math";
	panose-1:2 4 5 3 5 4 6 3 2 4;}
@font-face
	{font-family:Calibri;
	panose-1:2 15 5 2 2 2 4 3 2 4;}
@font-face
	{font-family:Aptos;}
@font-face
	{font-family:"MS PGothic";
	panose-1:2 11 6 0 7 2 5 8 2 4;}
@font-face
	{font-family:"\@MS PGothic";}
@font-face
	{font-family:"\@Gulim";
	panose-1:2 11 6 0 0 1 1 1 1 1;}
/* Style Definitions */
p.MsoNormal, li.MsoNormal, div.MsoNormal
	{margin:0cm;
	font-size:11.0pt;
	font-family:"Aptos",sans-serif;
	mso-ligatures:standardcontextual;
	mso-fareast-language:JA;}
a:link, span.MsoHyperlink
	{mso-style-priority:99;
	color:#467886;
	text-decoration:underline;}
p.MsoListParagraph, li.MsoListParagraph, div.MsoListParagraph
	{mso-style-priority:34;
	margin-top:0cm;
	margin-right:0cm;
	margin-bottom:0cm;
	margin-left:36.0pt;
	font-size:11.0pt;
	font-family:"Aptos",sans-serif;
	mso-ligatures:standardcontextual;
	mso-fareast-language:JA;}
span.EmailStyle21
	{mso-style-type:personal-reply;
	font-family:"Calibri",sans-serif;
	color:#7030A0;
	font-weight:normal;
	font-style:normal;
	text-decoration:none none;}
.MsoChpDefault
	{mso-style-type:export-only;
	font-size:10.0pt;
	mso-ligatures:none;}
@page WordSection1
	{size:612.0pt 792.0pt;
	margin:72.0pt 72.0pt 72.0pt 72.0pt;}
div.WordSection1
	{page:WordSection1;}
/* List Definitions */
@list l0
	{mso-list-id:494496594;
	mso-list-template-ids:-575793578;}
@list l1
	{mso-list-id:1814715072;
	mso-list-type:hybrid;
	mso-list-template-ids:-1592213718 67698703 67698713 67698715 67698703 6769=
8713 67698715 67698703 67698713 67698715;}
@list l1:level1
	{mso-level-tab-stop:none;
	mso-level-number-position:left;
	text-indent:-18.0pt;}
@list l1:level2
	{mso-level-number-format:alpha-lower;
	mso-level-tab-stop:none;
	mso-level-number-position:left;
	text-indent:-18.0pt;}
@list l1:level3
	{mso-level-number-format:roman-lower;
	mso-level-tab-stop:none;
	mso-level-number-position:right;
	text-indent:-9.0pt;}
@list l1:level4
	{mso-level-tab-stop:none;
	mso-level-number-position:left;
	text-indent:-18.0pt;}
@list l1:level5
	{mso-level-number-format:alpha-lower;
	mso-level-tab-stop:none;
	mso-level-number-position:left;
	text-indent:-18.0pt;}
@list l1:level6
	{mso-level-number-format:roman-lower;
	mso-level-tab-stop:none;
	mso-level-number-position:right;
	text-indent:-9.0pt;}
@list l1:level7
	{mso-level-tab-stop:none;
	mso-level-number-position:left;
	text-indent:-18.0pt;}
@list l1:level8
	{mso-level-number-format:alpha-lower;
	mso-level-tab-stop:none;
	mso-level-number-position:left;
	text-indent:-18.0pt;}
@list l1:level9
	{mso-level-number-format:roman-lower;
	mso-level-tab-stop:none;
	mso-level-number-position:right;
	text-indent:-9.0pt;}
ol
	{margin-bottom:0cm;}
ul
	{margin-bottom:0cm;}
--></style><!--[if gte mso 9]><xml>
<o:shapedefaults v:ext=3D"edit" spidmax=3D"1026" />
</xml><![endif]--><!--[if gte mso 9]><xml>
<o:shapelayout v:ext=3D"edit">
<o:idmap v:ext=3D"edit" data=3D"1" />
</o:shapelayout></xml><![endif]-->
</head>
<body lang=3D"EN-GB" link=3D"#467886" vlink=3D"#96607D" style=3D"word-wrap:=
break-word">
<div class=3D"WordSection1">
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Calibri&quot;,sans-=
serif;color:#7030A0;mso-fareast-language:EN-US">Hello Sai,<o:p></o:p></span=
></p>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Calibri&quot;,sans-=
serif;color:#7030A0;mso-fareast-language:EN-US"><o:p>&nbsp;</o:p></span></p=
>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Calibri&quot;,sans-=
serif;color:#7030A0;mso-fareast-language:EN-US">I=A1=AFve created a new gro=
up and the projects you=A1=AFve asked for:
<a href=3D"https://squad.ciplatform.org/cip-core/">https://squad.ciplatform=
.org/cip-core/</a><o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Calibri&quot;,sans-=
serif;color:#7030A0;mso-fareast-language:EN-US">I=A1=AFve also created a us=
er for you. I=A1=AFll email the details separately.<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Calibri&quot;,sans-=
serif;color:#7030A0;mso-fareast-language:EN-US">You=A1=AFll be able to log =
in and view your token here:
<a href=3D"https://squad.ciplatform.org/_/settings/api-token/">https://squa=
d.ciplatform.org/_/settings/api-token/</a><o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Calibri&quot;,sans-=
serif;color:#7030A0;mso-fareast-language:EN-US"><o:p>&nbsp;</o:p></span></p=
>
<div>
<p class=3D"MsoNormal"><span style=3D"color:#7030A0;mso-ligatures:none;mso-=
fareast-language:EN-GB">Kind regards, Chris<o:p></o:p></span></p>
</div>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Calibri&quot;,sans-=
serif;color:#7030A0;mso-fareast-language:EN-US"><o:p>&nbsp;</o:p></span></p=
>
<div style=3D"border:none;border-left:solid blue 1.5pt;padding:0cm 0cm 0cm =
4.0pt">
<div>
<div style=3D"border:none;border-top:solid #E1E1E1 1.0pt;padding:3.0pt 0cm =
0cm 0cm">
<p class=3D"MsoNormal"><b><span lang=3D"EN-US" style=3D"font-family:&quot;C=
alibri&quot;,sans-serif;mso-ligatures:none;mso-fareast-language:KO">From:</=
span></b><span lang=3D"EN-US" style=3D"font-family:&quot;Calibri&quot;,sans=
-serif;mso-ligatures:none;mso-fareast-language:KO"> Sai.Sathujoda@toshiba-t=
sip.com
 &lt;Sai.Sathujoda@toshiba-tsip.com&gt; <br>
<b>Sent:</b> Thursday, May 9, 2024 6:25 PM<br>
<b>To:</b> Chris Paterson &lt;Chris.Paterson2@renesas.com&gt;<br>
<b>Cc:</b> Sietze.vanBuuren@de.bosch.com; cip-dev@lists.cip-project.org; di=
nesh.kumar@toshiba-tsip.com<br>
<b>Subject:</b> RE: Query regarding SQUAD watch job submission<o:p></o:p></=
span></p>
</div>
</div>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US" style=3D"mso-fareast-language:E=
N-US">Hello Chris,<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US" style=3D"mso-fareast-language:E=
N-US"><o:p>&nbsp;</o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US" style=3D"mso-fareast-language:E=
N-US">Hope you are doing well.<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US" style=3D"mso-fareast-language:E=
N-US"><o:p>&nbsp;</o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US" style=3D"mso-fareast-language:E=
N-US">The issue I mentioned in the previous mail in this thread is resolved=
 now so please ignore that query if you have not gone through yet.<o:p></o:=
p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US" style=3D"mso-fareast-language:E=
N-US"><o:p>&nbsp;</o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US" style=3D"mso-fareast-language:E=
N-US">As mentioned earlier we are planning to add CIP-Core LAVA test result=
s in CIP SQUAD. It will be of great help to us if you provide your support =
in this.<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US" style=3D"mso-fareast-language:E=
N-US"><o:p>&nbsp;</o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US" style=3D"mso-fareast-language:E=
N-US">Can you please create a group named =A1=B0linux-cip-core=A1=B1, three=
 projects named =A1=B0Swupdate-testing=A1=B1, =A1=B0Secure boot testing=A1=
=B1 and =A1=B0IEC Layer testing=A1=B1 under that group ?<o:p></o:p></span><=
/p>
<p class=3D"MsoNormal"><span lang=3D"EN-US" style=3D"mso-fareast-language:E=
N-US"><o:p>&nbsp;</o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US" style=3D"mso-fareast-language:E=
N-US">Currently I believe that results present under various projects in =
=A1=B0linux-cip=A1=B1 and =A1=B0linux-stable-rc=A1=B1 will not be disturbed=
 while we experiment in adding CIP Core LAVA results in the
 projects under =A1=B0linux-cip-core=A1=B1 group. Please correct me if I am=
 wrong about this.<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US" style=3D"mso-fareast-language:E=
N-US"><o:p>&nbsp;</o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US" style=3D"mso-fareast-language:E=
N-US">We also need a user created in CIP SQUAD with a SQUAD token assigned =
to, so that we can start modifying this script
</span><span lang=3D"EN-US"><a href=3D"https://gitlab.com/cip-playground/ci=
p-core-ci/-/blob/master/lava.sh?ref_type=3Dheads">lava.sh =A1=A4 master =A1=
=A4 cip-playground / cip-core-ci =A1=A4 GitLab</a> to experiment on hosting=
 CIP Core LAVA results on SQUAD.<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US"><o:p>&nbsp;</o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">Chris, I request you to add the=
 mentioned items to CIP SQUAD which will help us to start this task as soon=
 as possible.<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US"><o:p>&nbsp;</o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">If there are any issues with do=
ing these changes to current CIP SQUAD, please let me know.<o:p></o:p></spa=
n></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US"><o:p>&nbsp;</o:p></span></p>
<p class=3D"MsoNormal"><b><span lang=3D"EN-US">Note: If anyone has any conc=
erns about the group and project names proposed above, please reply to this=
 email.<o:p></o:p></span></b></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US"><o:p>&nbsp;</o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">Thanks and regards,<o:p></o:p><=
/span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">Sai Ashrith Sathujoda (T S I P)=
 </span><span lang=3D"EN-US" style=3D"mso-fareast-language:EN-US"><o:p></o:=
p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US" style=3D"mso-fareast-language:E=
N-US"><o:p>&nbsp;</o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US" style=3D"mso-fareast-language:E=
N-US"><o:p>&nbsp;</o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US" style=3D"mso-fareast-language:E=
N-US"><o:p>&nbsp;</o:p></span></p>
<div>
<div style=3D"border:none;border-top:solid #E1E1E1 1.0pt;padding:3.0pt 0cm =
0cm 0cm">
<p class=3D"MsoNormal"><b><span lang=3D"EN-US" style=3D"font-family:&quot;C=
alibri&quot;,sans-serif;mso-ligatures:none">From:</span></b><span lang=3D"E=
N-US" style=3D"font-family:&quot;Calibri&quot;,sans-serif;mso-ligatures:non=
e"> ashrith sai(</span><span lang=3D"JA" style=3D"font-family:&quot;MS PGot=
hic&quot;,sans-serif;mso-ligatures:none">=A3=D4=A3=D3=A3=C9=A3=D0</span><sp=
an lang=3D"EN-US" style=3D"font-family:&quot;Calibri&quot;,sans-serif;mso-l=
igatures:none">)
<br>
<b>Sent:</b> Friday, May 3, 2024 12:53 AM<br>
<b>To:</b> Chris Paterson &lt;<a href=3D"mailto:Chris.Paterson2@renesas.com=
">Chris.Paterson2@renesas.com</a>&gt;<br>
<b>Cc:</b> <a href=3D"mailto:Sietze.vanBuuren@de.bosch.com">Sietze.vanBuure=
n@de.bosch.com</a>;
<a href=3D"mailto:cip-dev@lists.cip-project.org">cip-dev@lists.cip-project.=
org</a><br>
<b>Subject:</b> Query regarding SQUAD watch job submission<o:p></o:p></span=
></p>
</div>
</div>
<p class=3D"MsoNormal"><span lang=3D"EN-US"><o:p>&nbsp;</o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">Hi Chris,<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US"><o:p>&nbsp;</o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">Hope you are doing well.<o:p></=
o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US"><o:p>&nbsp;</o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">We are planning to post CIP Cor=
e LAVA testing results on CIP SQUAD instance. So I am trying to setup a loc=
al SQUAD instance and integrate it with my local LAVA Lab so that I can und=
erstand the traceability between changes
 required in <a href=3D"https://gitlab.com/cip-playground/cip-core-ci/-/blo=
b/master/lava.sh?ref_type=3Dheads">
https://gitlab.com/cip-playground/cip-core-ci/-/blob/master/lava.sh?ref_typ=
e=3Dheads</a> and results displayed on the dashboard.<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US"><o:p>&nbsp;</o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">I followed the below mentioned =
steps:<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US"><o:p>&nbsp;</o:p></span></p>
<ol style=3D"margin-top:0cm" start=3D"1" type=3D"1">
<li class=3D"MsoListParagraph" style=3D"margin-left:0cm;mso-list:l1 level1 =
lfo3"><span lang=3D"EN-US">I started the server locally after following the=
 steps mentioned in this README file
<a href=3D"https://github.com/Linaro/squad/blob/master/doc/quickstart.rst">=
squad/doc/quickstart.rst at master =A1=A4 Linaro/squad =A1=A4 GitHub</a> .<=
o:p></o:p></span></li><li class=3D"MsoListParagraph" style=3D"margin-left:0=
cm;mso-list:l1 level1 lfo3"><span lang=3D"EN-US">After the server started, =
I was able to access web UI at localhost:8000.<o:p></o:p></span></li><li cl=
ass=3D"MsoListParagraph" style=3D"margin-left:0cm;mso-list:l1 level1 lfo3">=
<span lang=3D"EN-US">I followed the steps mentioned in
<a href=3D"https://github.com/Linaro/squad/blob/master/doc/lava_usecase.rst=
#creating-a-backend-for-a-lava-instance">
https://github.com/Linaro/squad/blob/master/doc/lava_usecase.rst#creating-a=
-backend-for-a-lava-instance</a> to&nbsp; create backend for my LAVA instan=
ce.<o:p></o:p></span></li><li class=3D"MsoListParagraph" style=3D"margin-le=
ft:0cm;mso-list:l1 level1 lfo3"><span lang=3D"EN-US">I created a fresh toke=
n in API -&gt; Authentication token in my local LAVA Lab and I added that t=
oken while creating the SQUAD backend.<o:p></o:p></span></li><li class=3D"M=
soListParagraph" style=3D"margin-left:0cm;mso-list:l1 level1 lfo3"><span la=
ng=3D"EN-US">I created a SQUAD token based on my SQUAD username and I refer=
enced that token as value to
<b>Authorization token: </b>while using SQUAD watch job API.<o:p></o:p></sp=
an></li><li class=3D"MsoListParagraph" style=3D"margin-left:0cm;mso-list:l1=
 level1 lfo3"><span lang=3D"EN-US">I added my LAVA username in the username=
 section while creating the backend.<o:p></o:p></span></li><li class=3D"Mso=
ListParagraph" style=3D"margin-left:0cm;mso-list:l1 level1 lfo3"><span lang=
=3D"EN-US">I created a sample group in the administration page, and I selec=
ted that group slug while creating a project in administration page.<o:p></=
o:p></span></li></ol>
<p class=3D"MsoNormal"><span lang=3D"EN-US"><o:p>&nbsp;</o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">After I gathered all these deta=
ils, I modified submit_jobs script to test whether I can attach a SQUAD wat=
ch job to a just-submitted LAVA job based on it=A1=AFs job ID.
<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US"><o:p>&nbsp;</o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">After I submit my job to LAVA, =
I am immediately calling the watch job API to attach a watch job to the sub=
mitted LAVA job. But I am getting the below mentioned error message.<o:p></=
o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US"><o:p>&nbsp;</o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US" style=3D"font-size:10.0pt;font-=
family:&quot;Courier New&quot;">$ ./local_lava.sh<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US" style=3D"font-size:10.0pt;font-=
family:&quot;Courier New&quot;">/tmp/tmp.FJGGBcxzNn/IEC_amd64.yml is a vali=
d definition<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US" style=3D"font-size:10.0pt;font-=
family:&quot;Courier New&quot;">There are currently 1 &quot;qemu&quot; devi=
ces online.<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US" style=3D"font-size:10.0pt;font-=
family:&quot;Courier New&quot;">Submitting /tmp/tmp.FJGGBcxzNn/IEC_amd64.ym=
l to LAVA master...<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US" style=3D"font-size:10.0pt;font-=
family:&quot;Courier New&quot;">Job submitted successfully as #634.<o:p></o=
:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US" style=3D"font-size:10.0pt;font-=
family:&quot;Courier New&quot;">&nbsp; % Total&nbsp;&nbsp;&nbsp; % Received=
 % Xferd&nbsp; Average Speed&nbsp;&nbsp; Time&nbsp;&nbsp;&nbsp; Time&nbsp;&=
nbsp;&nbsp;&nbsp; Time&nbsp; Current<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US" style=3D"font-size:10.0pt;font-=
family:&quot;Courier New&quot;">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
Dload&nbsp; Upload&nbsp;&nbsp; Total&nbsp;&nbsp; Spent&nbsp;&nbsp;&nbsp; Le=
ft&nbsp; Speed<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US" style=3D"font-size:10.0pt;font-=
family:&quot;Courier New&quot;">100&nbsp;&nbsp; 315&nbsp; 100&nbsp;&nbsp;&n=
bsp; 56&nbsp; 100&nbsp;&nbsp; 259&nbsp;&nbsp; 9333&nbsp; 43166 --:--:-- --:=
--:-- --:--:-- 52500<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US" style=3D"font-size:10.0pt;font-=
family:&quot;Courier New&quot;">Something went wrong with SQUAD watch job s=
ubmission. SQUAD returned:<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US" style=3D"font-size:10.0pt;font-=
family:&quot;Courier New&quot;">{&quot;detail&quot;: &quot;User needs permi=
ssion to submit test jobs.&quot;}<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US" style=3D"font-size:10.0pt;font-=
family:&quot;Courier New&quot;">SQUAD URL:
<a href=3D"http://127.0.0.1:8000/api/submitjob/tsip_squad/cip-core-testing/=
2.0/local_env">
http://127.0.0.1:8000/api/submitjob/tsip_squad/cip-core-testing/2.0/local_e=
nv</a><o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US" style=3D"font-size:10.0pt;font-=
family:&quot;Courier New&quot;">SQUAD Backend: lavabackend.org<o:p></o:p></=
span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US" style=3D"font-size:10.0pt;font-=
family:&quot;Courier New&quot;">LAVA Job Id: 634</span><span lang=3D"EN-US"=
><o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US"><o:p>&nbsp;</o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">I am attaching my script to thi=
s email which can make it easier for you to point my mistakes. No issues re=
garding the exposed token I am using in the script since this is a local se=
tup done for my understanding. Please
 have a look at lines <b>17-22 </b>and <b>107-137 </b>which contain changes=
 made to call SQUAD watch job API.<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US"><o:p>&nbsp;</o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">I will also attach screenshots =
for group, project and backend page in my SQUAD admin section which might b=
e helpful to point out if I passed wrong data to SQUAD watch job API call.<=
o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US"><o:p>&nbsp;</o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">Please have a look at this data=
 and kindly provide your suggestions which can help me fix this problem.<o:=
p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US"><o:p>&nbsp;</o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">Thanks and regards,<o:p></o:p><=
/span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">Sai Ashrith Sathujoda (T S I P)=
<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US"><o:p>&nbsp;</o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US"><o:p>&nbsp;</o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US"><o:p>&nbsp;</o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US"><o:p>&nbsp;</o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US"><o:p>&nbsp;</o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US"><o:p>&nbsp;</o:p></span></p>
</div>
</div>
</body>
</html>

--_000_TYWPR01MB1186205A8C7B706EA3BD3E664B7E32TYWPR01MB11862jp_--

