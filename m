Return-Path: <quirin.gylstorff@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 451E6ECD99C
	for <webhook@archiver.kernel.org>; Thu,  5 Feb 2026 19:57:53 +0000 (UTC)
Received: from AS8PR04CU009.outbound.protection.outlook.com (AS8PR04CU009.outbound.protection.outlook.com [52.101.70.46])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.30096.1770321471967988752
 for <cip-dev@lists.cip-project.org>;
 Thu, 05 Feb 2026 11:57:52 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=F9KczwFJ;
 spf=pass (domain: siemens.com, ip: 52.101.70.46, mailfrom: quirin.gylstorff@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qpJFCMsLHBnyARqCYbGq9SyJXlkDTHM1sa6X1GAmS4RCnl5+Q0gGl45s83fh2Uu6sB0DiTcUVIvcYNktO4K6Z9M/YLFJHLoJC0BDC/f/El5LXRfE+6csrEo+HmrmGUtf1CJ+nJaEswlPyRcLXV3GoeA9WLMosJExTPDoOO5LvTR0w+zdn7Rw3JddtjxUjz64akmSYs6nPW3QTOgU5R82LCc5oDVssNYtR6pVy6k7o8yDOClHtTTeu9o6izCV4831LlFUGuuJx0fAqcQDJC7K9JV6Nw1Q7goPmryPSWif2GO31AmWmyr9NJxiLtV4VqgWhHmWuyLCT9chS3BbDMM1BA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZmRhGzWzT2SzGfpwkKRqbTTemDw+kxCb5j6b7JpX9+4=;
 b=vTqYvfAT3tlgNaS+HED2cqdrc8g6r2eJOXMrzpYqdOX25hi0s4d8xjEA167c8EH4Vs3cJWW+kMcecE9Bxr74rlnG1diQaR1si5b3CwHT0TP4T9mvOTxs6+/YVCxN7vqGjkq1enH9aPr35ee0v99JWUdnTtlapoZ4JwcLVQrZAHA8YHhomom1/Qiy2l4f+nW6tRy1mlx9IjSLAUxyWTG4JQ3nuJRRNXKBDMaxFwyP8ZtEa8MjTv56/ySs+i7pasyOFMsJ4UBzUclIko2RqAFLatpiIjJPm+zHf/p0FDSgiZBeRy7+d/vPVjh8Lkv54Mv3Pprvj+IXxSumcMK/+PFbNg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZmRhGzWzT2SzGfpwkKRqbTTemDw+kxCb5j6b7JpX9+4=;
 b=F9KczwFJ9rV2LdZN3w3IWpxrILlrqyMPhzxOy6nhcDU2bFwitCxC2Y92IFzssiTu/ESfWppzjCijrabJjnQLZajPV81XUlhfpKLdxPldBYabh6ytyhL1409iRQWKc/FIOSRwNZFZi3eOGvK8i2XMfz7FmUuihp0oGZE7qFMc5XitRJsMCcKLY2qRUPmhvZpOXjFr2svrnJTZGdoaYO4CoKm07W/WqtYI3m8DEWg5prsNm7ikjcGYYSstXZh7oqdSLP+IZ9gd8lKTwI2Wez8H8iCig5YNwyT5mFtixD1HR3FgtE6evKw+wLSMKioRQ86RnEeTSUZ0d+2WjLBXui33sw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from VI1PR10MB2319.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:803:89::19)
 by GV1PR10MB8824.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:150:1d3::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9564.16; Thu, 5 Feb
 2026 19:57:48 +0000
Received: from VI1PR10MB2319.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::b57f:1a19:e3c8:fbb6]) by VI1PR10MB2319.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::b57f:1a19:e3c8:fbb6%6]) with mapi id 15.20.9587.013; Thu, 5 Feb 2026
 19:57:47 +0000
Message-ID: <755e4a71-6a1b-40d9-829a-203ae7a44b2b@siemens.com>
Date: Thu, 5 Feb 2026 20:57:46 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [isar-cip-core][PATCH] swupdate: use self-built 2025.12 for
 Debian Trixie
To: "Prusty, Badrikesh (FT FDS CES LX PBU 2)" <badrikesh.prusty@siemens.com>,
 "Kiszka, Jan (FT RPD CED)" <jan.kiszka@siemens.com>,
 "cip-dev@lists.cip-project.org" <cip-dev@lists.cip-project.org>
References: <20260205163727.2995422-1-badrikesh.prusty@siemens.com>
 <944f83ee-b233-46d0-9e2d-f96af55cbecd@siemens.com>
 <SG2PR06MB51078D17CA7212B9DE6CE6039199A@SG2PR06MB5107.apcprd06.prod.outlook.com>
From: Quirin Gylstorff <quirin.gylstorff@siemens.com>
Content-Language: en-US
Autocrypt: addr=quirin.gylstorff@siemens.com; keydata=
 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
 Z2NBPBZUysw=
In-Reply-To: <SG2PR06MB51078D17CA7212B9DE6CE6039199A@SG2PR06MB5107.apcprd06.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0013.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:c8::6) To VI1PR10MB2319.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:803:89::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI1PR10MB2319:EE_|GV1PR10MB8824:EE_
X-MS-Office365-Filtering-Correlation-Id: 7c5d4262-853f-49af-e92d-08de64f0d5b5
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?ZUtZMlFLRnF6MTlIR0ZkODg0SFVSUGV4bVNLT01CZUtoencwQ2l3U1lEaHd3?=
 =?utf-8?B?U1lxWDdsV2gzTXZCU2JZa0gxdUNSRXByelhPMjBtV25FYXEraG5wcW9oUFlF?=
 =?utf-8?B?MkRaejAwdEpYMEJwYWlCVDhIdGw4V2ZNT3grSFRLZ25FbVNPSkYzU3Vxa3pw?=
 =?utf-8?B?WmhzaXFpUzdSVWVlZ20zcXVERGVNU2R2Wmo2Mnlnc3FabGNjZkJIcUxaNFB3?=
 =?utf-8?B?V2lhZVA0QkFrb2g2ZXZXdm1xeElkK2Zlc1FGRXhMaksyeFJYY1htY1E0a25r?=
 =?utf-8?B?eEF6SWhJRGJDU1cxZzdmMnFRaDZvMTE5QmNwanA3elkrSEg3OFNkOU9Ibmh0?=
 =?utf-8?B?SlgxNFdoSHpZOGhEWHgxTXVtWUhqKzdqSHZGNUticnRTRDBTWVRYcUxzTVU5?=
 =?utf-8?B?MVNRSC9UaFRMRVRLTEtvaFM2Qkd4SmFZSk5yZXhVN05udlR1a2liSVRDWmlz?=
 =?utf-8?B?aG9nS0NEckc0bUUzQ2lDaC9OR2dFUjg2Z3p3SUpiZzd0MDlSeHZPckV6eHZm?=
 =?utf-8?B?YlhCQ29YNE0yK3JnWGNFSi83VGhvamYyaytzQjJpYWJ4dHpQWlE1Q3NSVHdn?=
 =?utf-8?B?azFhMit0WTQ2R21jRHpWSE9UNGdGZFpaY1pjRFNzVm5CVzVjOExnck1oTXJz?=
 =?utf-8?B?SHQwd3diUjkyOVB4bmxrRzhoK1JUaFBDaWs4cTdvZEJDMFJHczgyZ1ZmRlMx?=
 =?utf-8?B?Q3h3ZTkyTGRXemVhNDMvYjlFN3RJVERQdDN0U2ljdG5YY3EwMi9FeVJMSXlp?=
 =?utf-8?B?eVZqUllyOXN0QU5qeHVOWlRpRXFrcjVMRXFKSS9iVkl0bnV1L0ZMamRVbFpS?=
 =?utf-8?B?RlEvdGppRFBML1hMbTZvdmcyRHRmd1Qrank5Q1F4L3lEYzcwWjQ0aWJHK0I1?=
 =?utf-8?B?dEs3R2wwQVR0S3I3Y3prV2lHOTRFNXp2Zm5UcmdYcndVM3N2YWppL1ljMHlK?=
 =?utf-8?B?V3hCRzZDQktVZDljMDRGV1VOYWIydklsTTF1VUVhOHgzaEVRc2FmNkVoRndi?=
 =?utf-8?B?R3RzTlh4cTdJY3VBSjR1SFRhTzBDN2g1TU0xa2ZDOXlZOGU0c3pYNXhNTURW?=
 =?utf-8?B?cStRNE9sUkcwRGJ2c2w1QmxwS0pBU0tUQkg3RFlweGZUQXovZTNnUXBYdTZq?=
 =?utf-8?B?WXVrRURYQW01c04rNC9UVG5SRkNXcjFqOXhndEtBRGJpRGttWUQzVldpWkp0?=
 =?utf-8?B?d2pudXp1a3p0Uy9BeWFrNUtZbFVZOFp3WkJzRjhpS3FXeDhlWGluOFVRTzNK?=
 =?utf-8?B?UEhOSWRxS28xdTRuTXlUMS9GV2pkejdTcjRJdHF3UU1vOXFWcGhTSi9SVmoz?=
 =?utf-8?B?SVYwNUZPazY1Q2JkTWpkSStVdmd6RzZMTEVXbjdDaWtud1lmaHJXTjFrdWJu?=
 =?utf-8?B?OHBwbm1pVWZZbW9nKzNaRWJDSVNOSkhYODdqWUdEL3Mrek5uSFAzZWp4K1Z5?=
 =?utf-8?B?Y3hpcUlEdnNOeEJMSWJuWGxPbmFCUDlhbmFBa0RkamRZNGNKbU1WVTRpT2NT?=
 =?utf-8?B?dGZFbHZiNHJEMzBFSnJDUVNkTkZRTVEzMkdLc0FJNUxkWjNIb2NBU3p6NHBs?=
 =?utf-8?B?VWxIc2RUSzAxVkJNRkRLcTAveE1ONklRcnBaTkFZWlpxNTV6ZDZ4eXNWdHR3?=
 =?utf-8?B?QnArUU8rVTdyZ2ZwVUlwbjcyTXpVbmNIN3hyYjdueTFWYnFLcGpUbU9QU3cr?=
 =?utf-8?B?cXVzZ1E2UVRKTUFoZC91U1FwTmZDT2Ezc25hOVFGSGtzd3grNW5EOXo4MG5k?=
 =?utf-8?B?ZmhucFZzUTU0VDhkck1Ucndsd1NqSVJpZmc5YVI4YkNhSE9IeFd4U0FiK3ln?=
 =?utf-8?B?d1RxMFhoQzRseE14Tk5QdE80eGlnaTQ3NVRpdCtjYk10N3h1S1lENWI3OVh5?=
 =?utf-8?B?bHpHQUYrRnlFOGN6VlA2eW9iMldhZ3ppd2Iwdy93VFV0ZC9FTUhvUWsyV2Vr?=
 =?utf-8?B?eW1JeE16d0JsQktINmo4dVc4WTVqdzArM1N0OUlQMlpqMEVnbVhrYWZGaGxh?=
 =?utf-8?B?dmljbWRiZWZjYm5tNCtvdnE0NDUzUmZyZjY3ZVhNT3BOWFUyZkFiT2Q5NVZH?=
 =?utf-8?B?YTFHeDM2RFoxYzdtQUJYOUpEcVh3a0hORFdIMitnQnRDWEhMbUlWNkVOYm43?=
 =?utf-8?Q?pGcDP5f23+cxjayQ77hQFyZJj?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR10MB2319.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?b2cwZWRXYUc4MUd6L1JmbllLRUsxbUhpVDlXWHpURDQ2VGtCeXdCUFdyMEh2?=
 =?utf-8?B?a3NzS3AzWGxZeW5VeDNoOXd2Q2xraE5BVGhTc09yWjMzMXRJcEtRYnY2L3BM?=
 =?utf-8?B?S3NmSi81U1RjUWNHcnlYQ0xXTGVDbVBVdlFaNXBBM3NSQXBpbDVYcGphb2tC?=
 =?utf-8?B?TzdWK3BBTTZFWm1tTHM4RmJycDFldjZ5QkZidWNSbVdPMk9RQVhTcFEvOUpC?=
 =?utf-8?B?OEtQQi9IYkg0anBTTkIxdFVzc3pSQlN4SnM0UzM1R1dBK2ovMndtNHRsbjJN?=
 =?utf-8?B?OHcvVHV4VGIveC9jR1hUckxiTTNiUk5vY25tS292RUtuRmtZTG5DNkJMc1cy?=
 =?utf-8?B?VFRDWjJNM09seXRqNi9qbnNMbXcxbjJ5SEFZVngzem9wMno5VFFaYTdnYzhI?=
 =?utf-8?B?QjMxWEtMU0lHSU9BZU14WGhxSzJVeitET3FjakUyQlRhcjVjSDlncWFqNzBV?=
 =?utf-8?B?Tll0aE5SSDNMZHZVeU90b29zb3FzMitjTWRlU2tJY2xuYklXeHpCeGkxOHph?=
 =?utf-8?B?UVFCR3pqNllhUmo0c1pZYnhGQ1A2bkxBR0N4WFRYb1NMVmp2a1BKR0hiVWVx?=
 =?utf-8?B?M3hhY0t0ZnZKR2h2Y2Y2RkgyT1hTL3dHRUtqSkpjYjFvUnJES0JRYnJqUVQz?=
 =?utf-8?B?VHd2RFUzNW9YTEZ5bEFwNGlYVGJldngxOW1ja1FuRzhUWkxrY01tUlNhclR1?=
 =?utf-8?B?aU5mK1RBbFJFL2E5a2ZKVGMySUNXam05K0YyenBuc1Fmbkx0anRnTDBOY3V1?=
 =?utf-8?B?K3R1aExTcjEycW5KTWU3Z2toNHA3K3VXeFh1WWFvZndiM0VuWTYrbU1GUXIy?=
 =?utf-8?B?aWpsTWI2Y0tTdm5zQWVhcmhBVkFJbjNEK20wSE1ZZDVvTnNWM1R5aU5QOHlD?=
 =?utf-8?B?VUgvMVZGWVhuSnBCK3hQcmwyK05oWlJyRjZZMHk2eGJ2ekR6NDF1OGhoTk5G?=
 =?utf-8?B?MldCSkVQcnl5cnorVFpqSEhQY3p5dC9DU0ZORElnNi9WZzdBNW5nVDNFTXZ0?=
 =?utf-8?B?TDZrYW5yRGlBbmNKUGhnUU1GNmxTWHlHK3lSZlVOaWIzelNLcmxVZUMwQU80?=
 =?utf-8?B?RE1NUEFpdjRiaWtkMjhsK0JqMWsxcmlQQTFnbGRFeGpnWjhmVVA5ZjVobHN1?=
 =?utf-8?B?SUNDVlJ4NWJOTGx6NjNvZ3R4R1NjT3dKM2pySWNDUHcwOHRnWWs1S0cveTBM?=
 =?utf-8?B?U1YvUk50QXpWeVE3QzdVN1NiajB2NldCUWNXUmVObWxQYkJQRmNNcms5enVU?=
 =?utf-8?B?ZlN5cVFkL3pTOW12ZlgzVytOUkNTSlhJK0NwZW5TZnNJM1hNcjhEMmgwdGZN?=
 =?utf-8?B?ZE1LbC9ldFlKR2hFTzVxWDdWelJyZGF1akIzaVo0cUg1MzBoMDJnbVNRTC9V?=
 =?utf-8?B?TkI4eGlRTlVVRHJDb21UdW1tVFdMck95Y2NQYXNNYitCOSs0a3liVHdzVG5m?=
 =?utf-8?B?Smkyc1BhNWNJaFhndUFpT083VkQrNno5Q0hBS2lrTXM3dnV1WjBlM0ZwaUVK?=
 =?utf-8?B?SUtTVVNoNWJkRndIV0xIK3NIWFJRZ1JhUm8wWEhNQ0ZYOHl1UFR2eGoxUzBR?=
 =?utf-8?B?N3loZldZVFNNN0hWNnVLWDhwZzFwcm5Yd0MvWVVITmx1eGQ5K3lRWkNiOVRJ?=
 =?utf-8?B?TUNJQW1MNE9wUmtYSDdXUUVnYnBVeGNSV2pxQ2VwakMxWGdiN0dRSmp0Wm1V?=
 =?utf-8?B?Zk54TDY4VXZMMS9KUGd0N05rQnB2TDJLYXUwY0FrRlpEandlZWk1eGtsT2V4?=
 =?utf-8?B?bis0dmxCOXhpL3JRV0lBaUxydU5sbHJURHJWcUlPWEhIMjRuR1lZNit2eHZp?=
 =?utf-8?B?QXpCNHhjS2VxWkFGSzI3c0t3S0RDdXQ3M3BsVlZtd2JjK01ScEM4cStkZ3l1?=
 =?utf-8?B?NXFpVG5Zd1hjVXB3a1ZBMkdKRVBNRWtMTkd6eUVTa3FmSFRDMUtLWS9zdjc4?=
 =?utf-8?B?WEdtWFFhUXZBNHZxbHhLM2YyQVErNjF1aTBsY2NEY1F3WGFISkpwNGFDNDQz?=
 =?utf-8?B?YVNZRWhTanM4ZkNrZzNLSVp6bytHTXFHc0o0ZkFObVg5WWNZV0R6eDhrWm92?=
 =?utf-8?B?TEx6RkZDUTVmbHdYU3pBUVhPVDlBZXJ2cEFzSUlyYnp6bWcvRjhBbmRwNFk2?=
 =?utf-8?B?cWRybWJ0aHlJUEM3M3BnQjI4QSswaWJQL3JQT0N6ck85YlVPKzk0QlFhNHcy?=
 =?utf-8?B?SlFWZUdOS1pwaFVLRDBLQ0FEUDNlWHBOeDhxUDZMUW5JQmQvUFFJKzU5MHFv?=
 =?utf-8?B?OGlOZFJvMklKQ3BhSkE1a3Rwd2x4d0dZbHZRYlhsc3BzVkJmWnI1RFBUSENZ?=
 =?utf-8?B?dHVjbFdJUWRvWUVqeDdWaTFqU1g0T3lEcGdGNFhSVkpxSmdTMHlmeFQ1NmQ2?=
 =?utf-8?Q?aXtcHSW4NqQysbe0=3D?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7c5d4262-853f-49af-e92d-08de64f0d5b5
X-MS-Exchange-CrossTenant-AuthSource: VI1PR10MB2319.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Feb 2026 19:57:47.4965
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2TTdVJbYsz3d+gAaUP/JCSUgieP6Ujv2x8RkKNmkf20QsCSCNR4JqXiDLTAx1WPmpsxxgMsujy+k9f+0V1B5s8MxF0hUvYz9Ca49699yvqE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR10MB8824
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 05 Feb 2026 19:57:53 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/21842



On 2/5/26 7:19 PM, Prusty, Badrikesh (FT FDS CES LX PBU 2) wrote:
> Hello Jan,
> 
> I have shared my changes as an MR for the debian/master branch here:
> https://salsa.debian.org/debian/swupdate/-/merge_requests/34
> Once it is approved and merged, we can look into backporting it to stable.
> 
> Many thanks,
> Badrikesh
> 
> ________________________________________
> From: Kiszka, Jan (FT RPD CED) <jan.kiszka@siemens.com>
> Sent: 05 February 2026 22:27
> To: Prusty, Badrikesh (FT FDS CES LX PBU 2); cip-dev@lists.cip-project.org; Gylstorff, Quirin (FT RPD CED OES-DE)
> Subject: Re: [isar-cip-core][PATCH] swupdate: use self-built 2025.12 for Debian Trixie
> 
> On 05.02.26 17:37, Badrikesh Prusty wrote:
>> Debian Trixie ships SWUpdate 2024.12 which has an issue: swupdate-client
>> ignores the daemon's RuntimeDirectory setting and always uses /tmp
>> sockets, causing IPC failures.
>>
>> This sets PREFERRED_VERSION_swupdate to 2025.12 and enables
>> SWUPDATE_SELFBUILT for Trixie. It also adds patches so control and
>> progress sockets are created under /run/swupdate by default,
>> matching documentation. swupdate-client now uses these sockets by
>> default when applying updates.
>>
>> Closes: #135
> 

NAK

Also this is the wrong fix. Please request an backport of 
https://github.com/sbabic/swupdate/commit/d7b54f2d68ac5e0df8be4b1a6a3715ea7214bbde

Quirin


> What's the state in Debian? Did they refuse to fix it in stable?
> 
> Jan
> 
>> Signed-off-by: Badrikesh Prusty <badrikesh.prusty@siemens.com>
>> ---
>>   conf/distro/cip-core-trixie.conf              |  1 +
>>   recipes-core/images/swupdate.inc              |  3 +-
>>   ...date-as-default-socket-directory-ins.patch | 49 +++++++++++++++++++
>>   recipes-core/swupdate/swupdate_2025.12.bb     | 43 ++++++++++++++++
>>   4 files changed, 95 insertions(+), 1 deletion(-)
>>   create mode 100644 recipes-core/swupdate/files/2025.12/0001-ipc-use-run-swupdate-as-default-socket-directory-ins.patch
>>   create mode 100644 recipes-core/swupdate/swupdate_2025.12.bb
>>
>> diff --git a/conf/distro/cip-core-trixie.conf b/conf/distro/cip-core-trixie.conf
>> index b133bbb..4ed2461 100644
>> --- a/conf/distro/cip-core-trixie.conf
>> +++ b/conf/distro/cip-core-trixie.conf
>> @@ -12,5 +12,6 @@
>>   require conf/distro/debian-trixie.conf
>>   require cip-core-common.inc
>>
>> +PREFERRED_VERSION_swupdate ?= "2025.12%"
>>   PREFERRED_VERSION_linux-cip ?= "6.12.%"
>>   PREFERRED_VERSION_linux-cip-rt ?= "6.12.%"
>> diff --git a/recipes-core/images/swupdate.inc b/recipes-core/images/swupdate.inc
>> index 00e972e..c9dbcde 100644
>> --- a/recipes-core/images/swupdate.inc
>> +++ b/recipes-core/images/swupdate.inc
>> @@ -42,10 +42,11 @@ SWUPDATE_SELFBUILT ?= "0"
>>   SWUPDATE_SELFBUILT:buster = "1"
>>   SWUPDATE_SELFBUILT:bullseye = "1"
>>   SWUPDATE_SELFBUILT:bookworm = "1"
>> +SWUPDATE_SELFBUILT:trixie = "1"
>>
>>   python() {
>>       base_distro = d.getVar('BASE_DISTRO_CODENAME')
>> -    if base_distro not in ['buster', 'bullseye', 'bookworm'] and \
>> +    if base_distro not in ['buster', 'bullseye', 'bookworm', 'trixie'] and \
>>          bb.utils.to_boolean(d.getVar('SWUPDATE_SELFBUILT')):
>>           bb.fatal(f'Self-built SWUpdate not supported for {base_distro}')
>>
>> diff --git a/recipes-core/swupdate/files/2025.12/0001-ipc-use-run-swupdate-as-default-socket-directory-ins.patch b/recipes-core/swupdate/files/2025.12/0001-ipc-use-run-swupdate-as-default-socket-directory-ins.patch
>> new file mode 100644
>> index 0000000..e87c8bc
>> --- /dev/null
>> +++ b/recipes-core/swupdate/files/2025.12/0001-ipc-use-run-swupdate-as-default-socket-directory-ins.patch
>> @@ -0,0 +1,49 @@
>> +From c89f62d0a68e5c45e3f052edf6c3d77bba8c67e5 Mon Sep 17 00:00:00 2001
>> +From: Badrikesh Prusty <badrikesh.prusty@siemens.com>
>> +Date: Tue, 3 Feb 2026 11:25:18 +0530
>> +Subject: [PATCH] ipc: use /run/swupdate as default socket directory instead of
>> + /tmp
>> +
>> +Change the default socket directory for control and progress IPC from
>> +/tmp to /run/swupdate.
>> +
>> +This aligns with systemd conventions (RuntimeDirectory=swupdate) and
>> +the documentation in `doc/source/swupdate.rst`. It also improves
>> +security by avoiding world-writable /tmp and provides deterministic,
>> +predictable paths for both daemon and clients.
>> +
>> +Signed-off-by: Badrikesh Prusty <badrikesh.prusty@siemens.com>
>> +---
>> + ipc/network_ipc.c  | 2 +-
>> + ipc/progress_ipc.c | 2 +-
>> + 2 files changed, 2 insertions(+), 2 deletions(-)
>> +
>> +diff --git a/ipc/network_ipc.c b/ipc/network_ipc.c
>> +index 099587d4..e167d0b1 100644
>> +--- a/ipc/network_ipc.c
>> ++++ b/ipc/network_ipc.c
>> +@@ -32,7 +32,7 @@ char *get_ctrl_socket(void) {
>> +                     socketdir = getenv("TMPDIR");
>> +             }
>> +             if (!socketdir)
>> +-                    socketdir = "/tmp";
>> ++                    socketdir = "/run/swupdate";
>> +             if (asprintf(&SOCKET_CTRL_PATH, "%s/%s", socketdir, SOCKET_CTRL_DEFAULT) == -1)
>> +                     return (char *)"/tmp/"SOCKET_CTRL_DEFAULT;
>> +     }
>> +diff --git a/ipc/progress_ipc.c b/ipc/progress_ipc.c
>> +index d3689271..382a83c9 100644
>> +--- a/ipc/progress_ipc.c
>> ++++ b/ipc/progress_ipc.c
>> +@@ -41,7 +41,7 @@ char *get_prog_socket(void) {
>> +                     socketdir = getenv("TMPDIR");
>> +             }
>> +             if(!socketdir){
>> +-                    socketdir = "/tmp";
>> ++                    socketdir = "/run/swupdate";
>> +             }
>> +             if (asprintf(&SOCKET_PROGRESS_PATH, "%s/%s", socketdir, SOCKET_PROGRESS_DEFAULT) == -1)
>> +                     return (char *)"/tmp/"SOCKET_PROGRESS_DEFAULT;
>> +--
>> +2.39.5
>> +
>> diff --git a/recipes-core/swupdate/swupdate_2025.12.bb b/recipes-core/swupdate/swupdate_2025.12.bb
>> new file mode 100644
>> index 0000000..d53545e
>> --- /dev/null
>> +++ b/recipes-core/swupdate/swupdate_2025.12.bb
>> @@ -0,0 +1,43 @@
>> +#
>> +# CIP Core, generic profile
>> +#
>> +# Copyright (c) Siemens AG, 2026
>> +#
>> +# Authors:
>> +#  Badrikesh Prusty <badrikesh.prusty@siemens.com>
>> +#
>> +# SPDX-License-Identifier: MIT
>> +
>> +inherit dpkg
>> +
>> +require swupdate.inc
>> +
>> +DEPENDS += "libebgenv-dev"
>> +DEPENDS += "libubootenv-dev"
>> +
>> +DEB_BUILD_PROFILES += "nodoc"
>> +DEB_BUILD_OPTIONS += "nodoc"
>> +
>> +FILESEXTRAPATHS:prepend := "${FILE_DIRNAME}/files/${PV}:"
>> +
>> +SRC_URI = "git://salsa.debian.org/debian/swupdate.git;protocol=https;branch=debian/master;destsuffix=${P}"
>> +
>> +SRCREV = "1fa1ce0c85423f228529d2fccbe8813f07040536"
>> +
>> +# patches
>> +SRC_URI += "file://0001-ipc-use-run-swupdate-as-default-socket-directory-ins.patch"
>> +
>> +# Disable cross for arm and arm64 on bullseye
>> +# with cross compile we have a unsat-dependency to dh-nodejs on arm/arm64
>> +ISAR_CROSS_COMPILE:bullseye = "0"
>> +
>> +# add cross build and deactivate testing for arm based builds
>> +DEB_BUILD_PROFILES += "cross nocheck"
>> +
>> +CHANGELOG_V ?= "${PV}+cip-${SRCREV}"
>> +
>> +do_prepare_build() {
>> +    deb_add_changelog
>> +    cd ${WORKDIR}
>> +    tar cJf ${PN}_${PV}+cip.orig.tar.xz ${TAR_REPRO_OPTS} ${P}
>> +}
> 
> --
> Siemens AG, Foundational Technologies
> Linux Expert Center


