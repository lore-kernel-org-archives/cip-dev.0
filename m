Return-Path: <sai.sathujoda@toshiba-tsip.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E129AC369BA
	for <webhook@archiver.kernel.org>; Wed, 16 Apr 2025 16:58:35 +0000 (UTC)
Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.131])
 by mx.groups.io with SMTP id smtpd.web11.24770.1744822714574769736
 for <cip-dev@lists.cip-project.org>;
 Wed, 16 Apr 2025 09:58:35 -0700
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: toshiba-tsip.com, ip: 210.130.202.131, mailfrom: sai.sathujoda@toshiba-tsip.com)
Received: by mo-csw.securemx.jp (mx-mo-csw1120) id 53GGwVS8175667; Thu, 17 Apr 2025 01:58:31 +0900
X-Iguazu-Qid: 2rWhiV7hSVnfubmPfV
X-Iguazu-QSIG: v=2; s=0; t=1744822710; q=2rWhiV7hSVnfubmPfV; m=giaBpLPBaml4v72ko00Rb5aBDGdac2BD5c2RQTJ3WhM=
Received: from imx2-a.toshiba.co.jp (imx2-a.toshiba.co.jp [106.186.93.35])
	by relay.securemx.jp (mx-mr1123) id 53GGwTea1430671
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Thu, 17 Apr 2025 01:58:30 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Fl0qRzSLiRe06t95hLZOp4AfN1tP5I45Pa2Vce4a1Y2S/zen0dmHifbw7pSfhJy2BI4s5yKNq0ZQIObdiOwAI7PL5U20NLw9IDADpnnDQ/ELdoiQKspdYblHTM18j8lR85KU2f06So/zFm0BzTlmvZMay9XF7/XzvtAisRrjT5ALzWEQwHjgdBJRGVqVmrGUWw4KEvIgGn4R03R0yzKMaYcQvEzuWnL8DXAgE7DUY5a6jUQPm2iiN/mL/urwUzmyLDwK08Peia4qjYq1XUpcWY0tU8lVNSysRX8rFN2SGjvnjci1qdDR/ZxHNkeg1wgFTUF3BYNi03d2/VkYkhViQw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+Q3SRzadWywkuXxPC6I1gBXRskRQOhaC6oSebsJjmyE=;
 b=y8eZQ2TmtbjoDbovPkYOrYAgLXuLLnj/BgB26bbjd/hYE2BIuP7NGgBfBQCbkmDTpOFXxViqnTLVcMGdmyiyKHwwqXt1Q2cOfdy/qv1bZZ4v1/XCh9N2NdrBQc/+QUFJP0WNePv+AWuHrhw8kXr69ncCiTpAdQWtFONFb12Cwxs9R6bShYgIb/JEFOGCrLtFHrS3hxeUhhr/fO/QmJIzqLAX4yHzirfujBjh+ZbaOEVJLG+9AjNpxdqPBOkXoaKpt5BVgFP2RN7XZR4Yg5vcqvG8hAGaGvMgb31UqtKuwJZiSofBco21rfAMdJaVP9SFrxXJ0FjdKwC7NE8ZkFnn5w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=toshiba-tsip.com; dmarc=pass action=none
 header.from=toshiba-tsip.com; dkim=pass header.d=toshiba-tsip.com; arc=none
From: <Sai.Sathujoda@toshiba-tsip.com>
To: <cip-dev@lists.cip-project.org>, <jan.kiszka@siemens.com>
CC: <dinesh.kumar@toshiba-tsip.com>, <kazuhiro3.hayashi@toshiba.co.jp>
Subject: Re: [cip-dev] [isar-cip-core v3 1/2] .gitlab-ci.yml: Set timeout
 value to run IEC layer tests for different targets.
Thread-Topic: [cip-dev] [isar-cip-core v3 1/2] .gitlab-ci.yml: Set timeout
 value to run IEC layer tests for different targets.
Thread-Index: AQHbrt+ktEQMDfR5iEaI1P5HVk3A87OmcwqAgAAN794=
Date: Wed, 16 Apr 2025 16:58:22 +0000
X-TSB-HOP2: ON
Message-ID: 
 <OSCPR01MB1483849AD6A77BF9A11D936CAC2BD2@OSCPR01MB14838.jpnprd01.prod.outlook.com>
References: <20250416145141.2678093-1-Sai.Sathujoda@toshiba-tsip.com>
 <20681ac7-eff7-4eb7-a666-805607d99f82@siemens.com>
In-Reply-To: <20681ac7-eff7-4eb7-a666-805607d99f82@siemens.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=toshiba-tsip.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OSCPR01MB14838:EE_|TYCPR01MB6398:EE_
x-ms-office365-filtering-correlation-id: 2a009556-5199-46a4-efbe-08dd7d07e573
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: 
 BCL:0;ARA:13230040|1800799024|376014|366016|38070700018|8096899003|13003099007|7053199007;
x-microsoft-antispam-message-info: 
 =?iso-2022-jp?B?RVBLdWNpSlVBaUxVdmVXa3M3d3p3dnRzOUhnTzFFQXFCV00rbG9nb3B1?=
 =?iso-2022-jp?B?b2tJdE9XV085ZnlzNjJCY0xVclE5eXRJa1YyL0R5OGErUWh2dm5hdXpP?=
 =?iso-2022-jp?B?ak4xbmY5YVExendCMGV2YjE4eWVoV0ZQTlozSUZsZHNJWE92aHlFamlJ?=
 =?iso-2022-jp?B?Kys1Vlp1enFRbUxoVVA5V2tpU0w5ZjBmem9PbnQ0SFdvaE5XSFZKSmpr?=
 =?iso-2022-jp?B?dHRPRmgrNVF3YXNla04vL3FLNXhlMXdVSWJiMDl0N2Vxb0FDYndSdXhu?=
 =?iso-2022-jp?B?NDNYQWZCeUJYRURuQzFzUzk5MVFJeHdiVlN6QlNWUTJEYm5YQkQ3RVk5?=
 =?iso-2022-jp?B?Lys4VFZZa2xRUkpTZG1RZzNQWEFUTVFyRG14TUtVWTZxL2s5SXE2Qllp?=
 =?iso-2022-jp?B?c2tyeXdOd2tqQm5CVEpzL2pIUkxvbDhqWXNiQjV3am5uM2xKS2ZrMmt3?=
 =?iso-2022-jp?B?a0J2cUlkdU9mdHJ0bkc0QlNCbStnb3g3RG9lc0dwaklCY3BkZTFqeTBJ?=
 =?iso-2022-jp?B?TUlGZ0dzWDBKcmdmUWp5bUpBbDdGbjNpWG1nYU10UGJ1bUJwUGsrUzZ3?=
 =?iso-2022-jp?B?MWorb2VuVWt2MjN1ZHhWanBwcnFjS1dBTGNUZm9BVU0vUnlrZ2dZOCth?=
 =?iso-2022-jp?B?TzhyTW9pZXN2Um5zeTZWWmRkTGJUSEJYVzQvbnVkdk9pNjRqMG51OVl6?=
 =?iso-2022-jp?B?bmRyOGJhNmNrckNXR2ZtdlBjbjZYSXVRVWpwYTZWeDF6QllwaWVtZVRp?=
 =?iso-2022-jp?B?RDBpbzcwS2V1M1R4VWhwcUorK2EvN2I2SjMvdzFHSnBzWnBacmJaTUwx?=
 =?iso-2022-jp?B?MzNMbmU4MnNKc2ZYYlQwaU03dG1Rb1I3RFRTc0lnMWdLS2hvaWExQlhX?=
 =?iso-2022-jp?B?NHk5NkI1TWYzTTIxSlFpN05VaGJJVnVvR1lBNXBvMGRWWXpDZTcvMW5t?=
 =?iso-2022-jp?B?b0NjNnM2VHNYRDNPYnMxWm1WU3MyaEY5N1ZKM0VYa1QxSXhCclZidktQ?=
 =?iso-2022-jp?B?alJyMkU5WUVocHowNDRBdHZ3enNYNkZXZlZuQmYyZ3NoZjZtWjg2ZHRX?=
 =?iso-2022-jp?B?dkhLZFJiTHViZ3R0Z0lid2JOdWtZK0wyY216dldUV3NjS3B4eWo2Zkc5?=
 =?iso-2022-jp?B?N1JCdS9YQXRiME00eVFnN0tFZkhleWRmaklHczZOQ0R0RVZPQ2tpRFNY?=
 =?iso-2022-jp?B?Yy9hZk5ETDMydmt1cHVqbFdzZHBCYlNKblNmQUlVS1ljam1XYnhaQXRE?=
 =?iso-2022-jp?B?cTVRREw3bWFLZGRhcVRoTW5QdDBRR0k5ZEUvRWZnTjFjR1V1QXNHUXE0?=
 =?iso-2022-jp?B?TXRpSkhIYTMwcHJDWEoyVkFHNzRzclpEclhNQ3NvRHM3R080YUk3a3E1?=
 =?iso-2022-jp?B?dmd0OVJocTRWOVlSZFFGaW93OWVpUVFMSTY2TzNrWWdpYXpublFKK3RQ?=
 =?iso-2022-jp?B?QWdoWmVmRS9DRGl2TUJndFlXY3l6cFRSa05OaDlhRDk4cnh2TEhsWWVH?=
 =?iso-2022-jp?B?bHhKVGdiRWkrOTJocnUxL3RVVlBwWTU0dGhtcmNBcjU0elNORWlUTURz?=
 =?iso-2022-jp?B?Z1BQYWpORjJ5Q3JJU05QekRWdFA2TTBCUkZYRHYyano5eGJoOG1hdVg4?=
 =?iso-2022-jp?B?eGhwZEZSM2lnemZycTM0YWNTb3dqVHlRMENYaGkrTTU3VmpuYnFtb2tL?=
 =?iso-2022-jp?B?UENhbU5PMVpBbWthTnl3WElFTFJXejY4c2VOTHU1ZzhTWitRL1NVa0JQ?=
 =?iso-2022-jp?B?eFB5azRsaUdNN0czbHVjMHFWdkQ4MHRlTncxMFFtRWdVbUtNbDF3bFlp?=
 =?iso-2022-jp?B?MHc5OFdITkFGSTVqSGFwM2dXdzdyUDBrRmFyc0U5cVBOVVhWNFFhdWZU?=
 =?iso-2022-jp?B?dXd0UWlLSmdLYVg4a2REZUNLRkloMHRWdlU1czlybnlsZStOTmdNQ05Y?=
 =?iso-2022-jp?B?VlZUNzZvcWJ1cGlSc2ZOUzRLZmxPZncxaGJxa2tja3p2dUJKSFVSeGdH?=
 =?iso-2022-jp?B?dHVGTm5hdEM1d3RjMEJnT2IwdFpyZURiTTdIVE1GRVNFTHVrL2hJc0Nh?=
 =?iso-2022-jp?B?K2E2ZDZ3NFBIdnZMRS9uVEFBbFJiTHpGdkpYbTlMRStkL3l2ZVV5cEQ5?=
 =?iso-2022-jp?B?UVZYd3pvWmxYZXE0bFZycHh6SFZ2R2tOaXhiaUU4SkR0c04vblJJTjky?=
 =?iso-2022-jp?B?MFRvPQ==?=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:ja;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OSCPR01MB14838.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(38070700018)(8096899003)(13003099007)(7053199007);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?iso-2022-jp?B?TEFUa1Y0U29sSlRKTjNQbGxxNDVyVEk1d1dSbFgzOGVtQ0hVelliVFNk?=
 =?iso-2022-jp?B?Z2ppSGZocDhENFBZOThYTEc0VGhvWGdaN3FPMHRnUk5jS20vK1pHazg5?=
 =?iso-2022-jp?B?bkZXMzY5d3RNbGV1N3EyL3FvUnArVnQ0QW4rRWYrNUZYUnk3UFZzTkZU?=
 =?iso-2022-jp?B?cmxqclpKMXZsWDFuR0FSRUh5amVjZjZUYXdEOWhYZ3RLRFFQSGgyRDk2?=
 =?iso-2022-jp?B?MWJQT1B0aUdxdkhmN0xVZ3B1Zzl6M1NUMGt2Z3kwMUcxUzZaMUlKNHd5?=
 =?iso-2022-jp?B?aXZ3ZVhwRmdDa2E4c1dKSzlHWU5iVndzVk1SUkMvcTBsRnJoY3JxTzRt?=
 =?iso-2022-jp?B?NWt6S1UvR1J6MUx1Z2R6NU1TK3hzbVY2QXE4cmdWTGxSaUdnZWhmc1dw?=
 =?iso-2022-jp?B?N3BVT052VXIzSGlWRnVXRjFTZUFIUWZvREp1QUY4bGFUeHlJVVZnOWlL?=
 =?iso-2022-jp?B?VzU3aXRnai81L1h6UDlaVFNXY0FreXNtQWNRV1VPaDN3VTA1U0xSZHVt?=
 =?iso-2022-jp?B?UkdwUE5JOFkrcGxYZGI0OXNhRW9NTWkzVGJqNHFNTlpHaGJHd0hsYW5y?=
 =?iso-2022-jp?B?U0lzdDRYNlFUeUI2S1lIQ2NPanUvaHN2bWNXOVNuOUptRmxUMGhqejZF?=
 =?iso-2022-jp?B?UHZwdUJZaGtXMWN5aVFESmlhQ1pQVW9OSUZETVFNR2UwU1ZRY25KSzZV?=
 =?iso-2022-jp?B?Y0F4N1dsSXZiUXArdnpEa0ZHaElXejl0dHBkRzBDUDE3OFZCWUNCWXl1?=
 =?iso-2022-jp?B?RE5NY1U0VXFxL0pCTDdjcm1yU21DTXNBczhyVHBlSkIvblh6aEVubE9M?=
 =?iso-2022-jp?B?NE1SSjlNa093RWtmOHQ2SlJ0ZE9TVGxFM3pKSUg3aE1DbTlLbDJ6SHF2?=
 =?iso-2022-jp?B?ZUgrK1YwbXE3SmhnMCsrbWxySGxyRWxBOVVhb3RaamVaUEpWS1Z2M2w1?=
 =?iso-2022-jp?B?Q1Q3NmdGR2ZXUmdnZGhad0ZKemhhdDBBdnNaQjBUR01wN0UwWW9jcHJT?=
 =?iso-2022-jp?B?NVFxQ3Z4cXZHL09xM3VlUGh5Y3BXdWJHcVBZMGpGZ3VWckt3TENrcERL?=
 =?iso-2022-jp?B?TFRtWkl3VWJLNXQzckNmZDNRTXpSdzlza3AxTkJBNGdKcFhSNmdjTC9m?=
 =?iso-2022-jp?B?c2hoVVBVSHV1bWRqSUU1VStRSndDMk9Tb3lkVFdUNGl5Z0hkREVYZnZM?=
 =?iso-2022-jp?B?ODJJVGo5SkJQdXlYcXJzWUNJVmF6M21CZmg1czhTNHl6TTFpNktLNFFv?=
 =?iso-2022-jp?B?aWFmWWg2ZndWU2Vjb2xzQTdqRys1MXJzc2xQVkQ1YnpLRVFGQVN3WXhH?=
 =?iso-2022-jp?B?Mk53cnJ3QlRUQUlKdEc1Q1RqeW93UkZ5ay9ka1NoNGd6M1VMckNMZkEr?=
 =?iso-2022-jp?B?UnVpK0RHVlNFZXR0Q08vbDNETDZDNDV6MndxMHFyMjk5MDJtVHl4Mjlv?=
 =?iso-2022-jp?B?RElBZW5NK2Y2T09FOVdibXl3SCtqUnBXazM3WXJMbmR3T21UK2RPaHIr?=
 =?iso-2022-jp?B?T2h0V3F1TGhFUFpBY0VVdHV4T1p4NU1oM3dsazNIM3E0OC94c2JwZytH?=
 =?iso-2022-jp?B?SUNtYmpzLzZia2hpeDg1VlFXOHF5dVF5Q0FFTTFlYXFuWFdJMFZVMVp3?=
 =?iso-2022-jp?B?UUlSbC9FKzl6K3IwRXl2QkUvMktRTGlXZEVaRXc5N2VwMlp4aDhIR2g2?=
 =?iso-2022-jp?B?akhzdE81dzRJQlZ5cUdzWHF2UmQxaktSZmZPTU1XMDFzalBxMmx5aG5y?=
 =?iso-2022-jp?B?Z1dqb0srUzRTVTNPOENjb1d5UFNFS2JCZE40RTUyMSs1cnowQSs1elVx?=
 =?iso-2022-jp?B?NkxOWU5jQ25hSWJ3SWRObHVkNXdJU2J3U2dXQmxCUFVHcnk3Mm5BRytK?=
 =?iso-2022-jp?B?RzRuUk54UXFKbFFrb1pwYzdXQS9hTVBBZ0JRWDN0ZDgwcVRQM1UyR25E?=
 =?iso-2022-jp?B?OVZPTzZmOGtxRnA2TXBYc1UzOFBES09aNWxwRTRWMVVIQ09nMXZpUEJm?=
 =?iso-2022-jp?B?QUUzdytEczNJT2xobkZ4VjVVUkorV2F6b2ZHdHhyVWRDbmFaTkp2NFRr?=
 =?iso-2022-jp?B?S1RZRmVJalZGNzlqU0dURXZwK1JONExlVHdTOWh6MVhzWWJiOG9hK1Y4?=
 =?iso-2022-jp?B?M3c1RlZZam5iTG9WUDdzd2t0dUxPcjdXdzBRWWd4Y2VoN2VXWTB2TUtW?=
 =?iso-2022-jp?B?VHE0c0hzTUZoYnVRTmplWENST1ZjdzBhbW9qV3IxZlUzTlBsVUppRUVQ?=
 =?iso-2022-jp?B?QkRrMzMyUjNsSFBzZjl3OUMyYjZEY1FrWXZwTW0xeG5YSk1HbHhWTTBF?=
 =?iso-2022-jp?B?SWRCMDFoNVdMdEs0ME5oZ3NlOHJHNDBjcUE9PQ==?=
Content-Type: multipart/alternative;
	boundary="_000_OSCPR01MB1483849AD6A77BF9A11D936CAC2BD2OSCPR01MB14838jp_"
MIME-Version: 1.0
X-OriginatorOrg: toshiba-tsip.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OSCPR01MB14838.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2a009556-5199-46a4-efbe-08dd7d07e573
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Apr 2025 16:58:22.3779
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f109924e-fb71-4ba0-b2cc-65dcdf6fbe4f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Ht3K4PIqkumzfSIrLMN4TaiQ/f6Gmv3LR/kBbYSw/yxBRCDgKLiEjTwaKfcsFhvG9CdXSoY2OYlI/4EYSzBInyulwmbUPpNHcN1HsS2SOUs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYCPR01MB6398
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 16 Apr 2025 16:58:35 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/18514

--_000_OSCPR01MB1483849AD6A77BF9A11D936CAC2BD2OSCPR01MB14838jp_
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable

Hi Jan,

>> Can't we avoid this duplication? How about running envsubst
>> unconditionally on the final yml, just like xenomai-images does? That
>> will allow us to use this pattern not only for the IEC cases.

The timeout of 40 minutes and 60 minutes is only applicable for IEC tests o=
n QEMU and M-COM x86. For swupdate, secureboot related test cases that amou=
nt of time is not required.

That is why I added envsubst is qemu and m-com job creation methods separat=
ely. But as you suggested to reduce handling various timeout values, we can=
 set 60 minutes timeout to all the test jobs (IEC, swupdate) and we can jus=
t run envsubst directly on the final yaml as you said. Please confirm if yo=
u are OK with this. Then I will update and send v4. I will also include exp=
orting timeout value only once when submit_lava.sh script received the valu=
e from .gitlab-ci.yml in v4.

Thanks and regards,
Sai Ashrith





________________________________
From: cip-dev@lists.cip-project.org <cip-dev@lists.cip-project.org> on beha=
lf of Jan Kiszka via lists.cip-project.org <jan.kiszka=3Dsiemens.com@lists.=
cip-project.org>
Sent: Wednesday, April 16, 2025 9:28 PM
To: ashrith sai(=1B$B#T#S#I#P=1B(B DITC_DIT-OST) <Sai.Sathujoda@toshiba-tsi=
p.com>; cip-dev@lists.cip-project.org <cip-dev@lists.cip-project.org>
Cc: dinesh kumar(=1B$B#T#S#I#P=1B(B DITC_DIT-OST) <dinesh.kumar@toshiba-tsi=
p.com>; hayashi kazuhiro(=1B$BNS=1B(B =1B$BOB9(=1B(B =1B$B""#D#I#T#C!{#C#P#=
T=1B(B) <kazuhiro3.hayashi@toshiba.co.jp>
Subject: Re: [cip-dev] [isar-cip-core v3 1/2] .gitlab-ci.yml: Set timeout v=
alue to run IEC layer tests for different targets.

On 16.04.25 16:51, Sai.Sathujoda@toshiba-tsip.com wrote:
> From: sai ashrith sathujoda <sai.sathujoda@toshiba-tsip.com>
>
> Signed-off-by: sai ashrith sathujoda <sai.sathujoda@toshiba-tsip.com>
> ---
>  .gitlab-ci.yml                   | 6 +++++-
>  scripts/submit_lava.sh           | 5 +++++
>  tests/templates/IEC_template.yml | 2 +-
>  3 files changed, 11 insertions(+), 2 deletions(-)
>
> diff --git a/.gitlab-ci.yml b/.gitlab-ci.yml
> index 146eb33..2c1deaa 100644
> --- a/.gitlab-ci.yml
> +++ b/.gitlab-ci.yml
> @@ -334,7 +334,7 @@ build:qemu-riscv64:
>    tags:
>      - small
>    script:
> -    - scripts/submit_lava.sh ${test_function} ${target} ${CI_COMMIT_SHOR=
T_SHA} ${release} ${CI_COMMIT_REF_SLUG}
> +    - scripts/submit_lava.sh ${test_function} ${target} ${CI_COMMIT_SHOR=
T_SHA} ${release} ${CI_COMMIT_REF_SLUG} ${iec_test_timeout}
>    artifacts:
>      name: "$CI_JOB_NAME"
>      when: always
> @@ -431,6 +431,7 @@ test:qemu-amd64-IEC:
>    variables:
>      target: qemu-amd64
>      test_function: IEC
> +    iec_test_timeout: 40
>
>  test:qemu-arm64-IEC:
>    extends:
> @@ -439,6 +440,7 @@ test:qemu-arm64-IEC:
>    variables:
>      target: qemu-arm64
>      test_function: IEC
> +    iec_test_timeout: 40
>
>  test:qemu-arm-IEC:
>    extends:
> @@ -447,6 +449,7 @@ test:qemu-arm-IEC:
>    variables:
>      target: qemu-arm
>      test_function: IEC
> +    iec_test_timeout: 40
>
>  test:x86-uefi-IEC:
>    extends:
> @@ -455,6 +458,7 @@ test:x86-uefi-IEC:
>    variables:
>      target: x86-uefi
>      test_function: IEC
> +    iec_test_timeout: 60
>
>  test:qemu-amd64-secure-boot-unsigned-kernel:
>    extends:
> diff --git a/scripts/submit_lava.sh b/scripts/submit_lava.sh
> index 9da083a..028bad8 100755
> --- a/scripts/submit_lava.sh
> +++ b/scripts/submit_lava.sh
> @@ -24,6 +24,7 @@ TARGET=3D$2
>  COMMIT_REF=3D$3
>  RELEASE=3D$4
>  COMMIT_BRANCH=3D$5
> +IEC_TEST_TIMEOUT_MINUTES=3D$6

You can export already here.

>
>  if [ -z "$SUBMIT_ONLY" ]; then SUBMIT_ONLY=3Dfalse; fi
>
> @@ -55,6 +56,8 @@ add_firmware_artifacts () {
>  create_job_qemu () {
>        if [ "$1" =3D "IEC" ]; then
>                cp $LAVA_TEMPLATES/IEC_template.yml "${job_dir}/${1}_${2}.=
yml"
> +             export IEC_TEST_TIMEOUT_MINUTES
> +             envsubst < "${job_dir}/${1}_${2}.yml" > IEC.tmp && mv IEC.t=
mp "${job_dir}/${1}_${2}.yml"
>
>        elif [ "$1" =3D "swupdate" ]; then
>                cp $LAVA_TEMPLATES/swupdate_template.yml "${job_dir}/${1}_=
${2}.yml"
> @@ -163,6 +166,8 @@ create_job_mcom () {
>        cp $LAVA_TEMPLATES/M-COM-x86.yml "${job_dir}/${1}_${2}.yml"
>        if [ "$1" =3D "IEC" ]; then
>                grep -A 9 "# TEST_BLOCK" "$LAVA_TEMPLATES/$1_template.yml"=
 >> "${job_dir}/${1}_${2}.yml"
> +             export IEC_TEST_TIMEOUT_MINUTES
> +             envsubst < "${job_dir}/${1}_${2}.yml" > IEC.tmp && mv IEC.t=
mp "${job_dir}/${1}_${2}.yml"

Can't we avoid this duplication? How about running envsubst
unconditionally on the final yml, just like xenomai-images does? That
will allow us to use this pattern not only for the IEC cases.

>        elif [ "$1" =3D "secure-boot" ]; then
>                grep -A 1 "parameters" "$LAVA_TEMPLATES/secureboot_templat=
e.yml" >> "${job_dir}/${1}_${2}.yml"
>        else
> diff --git a/tests/templates/IEC_template.yml b/tests/templates/IEC_templ=
ate.yml
> index 92944da..c8efe40 100644
> --- a/tests/templates/IEC_template.yml
> +++ b/tests/templates/IEC_template.yml
> @@ -60,7 +60,7 @@ actions:
>  # TEST_BLOCK
>  - test:
>       timeout:
> -       minutes: 40
> +       minutes: ${IEC_TEST_TIMEOUT_MINUTES}
>       definitions:
>       - repository: https://gitlab.com/cip-project/cip-testing/cip-securi=
ty-tests.git
>         from: git

Jan

--
Siemens AG, Foundational Technologies
Linux Expert Center

--_000_OSCPR01MB1483849AD6A77BF9A11D936CAC2BD2OSCPR01MB14838jp_
Content-Type: text/html; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable

<html>
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Diso-2022-=
jp">
<style type=3D"text/css" style=3D"display:none;"> P {margin-top:0;margin-bo=
ttom:0;} </style>
</head>
<body dir=3D"ltr">
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
Hi Jan,</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
<br>
</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
&gt;&gt; Can't we avoid this duplication? How about running envsubst</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
&gt;&gt; unconditionally on the final yml, just like xenomai-images does? T=
hat</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
&gt;&gt; will allow us to use this pattern not only for the IEC cases.</div=
>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
<br>
</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
The timeout of 40 minutes and 60 minutes is only applicable for IEC tests o=
n QEMU and M-COM x86. For swupdate, secureboot related test cases that amou=
nt of time is not required.</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
<br>
</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
That is why I added envsubst is qemu and m-com job creation methods separat=
ely. But as you suggested to reduce handling various timeout values, we can=
 set 60 minutes timeout to all the test jobs (IEC, swupdate) and we can jus=
t run envsubst directly on the final
 yaml as you said. Please confirm if you are OK with this. Then I will upda=
te and send v4. I will also include exporting timeout value only once when =
submit_lava.sh script received the value from .gitlab-ci.yml in v4.</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
<br>
</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
Thanks and regards,</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
Sai Ashrith</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
<br>
</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
<br>
</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
<br>
</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
<br>
</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
<br>
</div>
<div id=3D"appendonsend"></div>
<hr style=3D"display:inline-block;width:98%" tabindex=3D"-1">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" st=
yle=3D"font-size:11pt" color=3D"#000000"><b>From:</b> cip-dev@lists.cip-pro=
ject.org &lt;cip-dev@lists.cip-project.org&gt; on behalf of Jan Kiszka via =
lists.cip-project.org &lt;jan.kiszka=3Dsiemens.com@lists.cip-project.org&gt=
;<br>
<b>Sent:</b> Wednesday, April 16, 2025 9:28 PM<br>
<b>To:</b> ashrith sai(=1B$B#T#S#I#P=1B(B DITC_DIT-OST) &lt;Sai.Sathujoda@t=
oshiba-tsip.com&gt;; cip-dev@lists.cip-project.org &lt;cip-dev@lists.cip-pr=
oject.org&gt;<br>
<b>Cc:</b> dinesh kumar(=1B$B#T#S#I#P=1B(B DITC_DIT-OST) &lt;dinesh.kumar@t=
oshiba-tsip.com&gt;; hayashi kazuhiro(=1B$BNS=1B(B =1B$BOB9(=1B(B =1B$B""#D=
#I#T#C!{#C#P#T=1B(B) &lt;kazuhiro3.hayashi@toshiba.co.jp&gt;<br>
<b>Subject:</b> Re: [cip-dev] [isar-cip-core v3 1/2] .gitlab-ci.yml: Set ti=
meout value to run IEC layer tests for different targets.</font>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt;=
">
<div class=3D"PlainText">On 16.04.25 16:51, Sai.Sathujoda@toshiba-tsip.com =
wrote:<br>
&gt; From: sai ashrith sathujoda &lt;sai.sathujoda@toshiba-tsip.com&gt;<br>
&gt; <br>
&gt; Signed-off-by: sai ashrith sathujoda &lt;sai.sathujoda@toshiba-tsip.co=
m&gt;<br>
&gt; ---<br>
&gt;&nbsp; .gitlab-ci.yml&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; | 6 +++++-<br>
&gt;&nbsp; scripts/submit_lava.sh&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp; | 5 +++++<br>
&gt;&nbsp; tests/templates/IEC_template.yml | 2 +-<br>
&gt;&nbsp; 3 files changed, 11 insertions(+), 2 deletions(-)<br>
&gt; <br>
&gt; diff --git a/.gitlab-ci.yml b/.gitlab-ci.yml<br>
&gt; index 146eb33..2c1deaa 100644<br>
&gt; --- a/.gitlab-ci.yml<br>
&gt; +++ b/.gitlab-ci.yml<br>
&gt; @@ -334,7 +334,7 @@ build:qemu-riscv64:<br>
&gt;&nbsp;&nbsp;&nbsp; tags:<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; - small<br>
&gt;&nbsp;&nbsp;&nbsp; script:<br>
&gt; -&nbsp;&nbsp;&nbsp; - scripts/submit_lava.sh ${test_function} ${target=
} ${CI_COMMIT_SHORT_SHA} ${release} ${CI_COMMIT_REF_SLUG}<br>
&gt; +&nbsp;&nbsp;&nbsp; - scripts/submit_lava.sh ${test_function} ${target=
} ${CI_COMMIT_SHORT_SHA} ${release} ${CI_COMMIT_REF_SLUG} ${iec_test_timeou=
t}<br>
&gt;&nbsp;&nbsp;&nbsp; artifacts:<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; name: &quot;$CI_JOB_NAME&quot;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; when: always<br>
&gt; @@ -431,6 +431,7 @@ test:qemu-amd64-IEC:<br>
&gt;&nbsp;&nbsp;&nbsp; variables:<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; target: qemu-amd64<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; test_function: IEC<br>
&gt; +&nbsp;&nbsp;&nbsp; iec_test_timeout: 40<br>
&gt;&nbsp; <br>
&gt;&nbsp; test:qemu-arm64-IEC:<br>
&gt;&nbsp;&nbsp;&nbsp; extends:<br>
&gt; @@ -439,6 +440,7 @@ test:qemu-arm64-IEC:<br>
&gt;&nbsp;&nbsp;&nbsp; variables:<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; target: qemu-arm64<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; test_function: IEC<br>
&gt; +&nbsp;&nbsp;&nbsp; iec_test_timeout: 40<br>
&gt;&nbsp; <br>
&gt;&nbsp; test:qemu-arm-IEC:<br>
&gt;&nbsp;&nbsp;&nbsp; extends:<br>
&gt; @@ -447,6 +449,7 @@ test:qemu-arm-IEC:<br>
&gt;&nbsp;&nbsp;&nbsp; variables:<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; target: qemu-arm<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; test_function: IEC<br>
&gt; +&nbsp;&nbsp;&nbsp; iec_test_timeout: 40<br>
&gt;&nbsp; <br>
&gt;&nbsp; test:x86-uefi-IEC:<br>
&gt;&nbsp;&nbsp;&nbsp; extends:<br>
&gt; @@ -455,6 +458,7 @@ test:x86-uefi-IEC:<br>
&gt;&nbsp;&nbsp;&nbsp; variables:<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; target: x86-uefi<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; test_function: IEC<br>
&gt; +&nbsp;&nbsp;&nbsp; iec_test_timeout: 60<br>
&gt;&nbsp; <br>
&gt;&nbsp; test:qemu-amd64-secure-boot-unsigned-kernel:<br>
&gt;&nbsp;&nbsp;&nbsp; extends:<br>
&gt; diff --git a/scripts/submit_lava.sh b/scripts/submit_lava.sh<br>
&gt; index 9da083a..028bad8 100755<br>
&gt; --- a/scripts/submit_lava.sh<br>
&gt; +++ b/scripts/submit_lava.sh<br>
&gt; @@ -24,6 +24,7 @@ TARGET=3D$2<br>
&gt;&nbsp; COMMIT_REF=3D$3<br>
&gt;&nbsp; RELEASE=3D$4<br>
&gt;&nbsp; COMMIT_BRANCH=3D$5<br>
&gt; +IEC_TEST_TIMEOUT_MINUTES=3D$6<br>
<br>
You can export already here.<br>
<br>
&gt;&nbsp; <br>
&gt;&nbsp; if [ -z &quot;$SUBMIT_ONLY&quot; ]; then SUBMIT_ONLY=3Dfalse; fi=
<br>
&gt;&nbsp; <br>
&gt; @@ -55,6 +56,8 @@ add_firmware_artifacts () {<br>
&gt;&nbsp; create_job_qemu () {<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if [ &quot;$1&quot; =3D &quo=
t;IEC&quot; ]; then<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; cp $LAVA_TEMPLATES/IEC_template.yml &quot;${job_dir}/${=
1}_${2}.yml&quot;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; export IEC_TEST_TIMEOUT_MINUTES<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; envsubst &lt; &quot;${job_dir}/${1}_${2}.yml&quot; &gt; IEC.tmp &amp;&a=
mp; mv IEC.tmp &quot;${job_dir}/${1}_${2}.yml&quot;<br>
&gt;&nbsp; <br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; elif [ &quot;$1&quot; =3D &q=
uot;swupdate&quot; ]; then<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; cp $LAVA_TEMPLATES/swupdate_template.yml &quot;${job_di=
r}/${1}_${2}.yml&quot;<br>
&gt; @@ -163,6 +166,8 @@ create_job_mcom () {<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; cp $LAVA_TEMPLATES/M-COM-x86=
.yml &quot;${job_dir}/${1}_${2}.yml&quot;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if [ &quot;$1&quot; =3D &quo=
t;IEC&quot; ]; then<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; grep -A 9 &quot;# TEST_BLOCK&quot; &quot;$LAVA_TEMPLATE=
S/$1_template.yml&quot; &gt;&gt; &quot;${job_dir}/${1}_${2}.yml&quot;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; export IEC_TEST_TIMEOUT_MINUTES<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; envsubst &lt; &quot;${job_dir}/${1}_${2}.yml&quot; &gt; IEC.tmp &amp;&a=
mp; mv IEC.tmp &quot;${job_dir}/${1}_${2}.yml&quot;<br>
<br>
Can't we avoid this duplication? How about running envsubst<br>
unconditionally on the final yml, just like xenomai-images does? That<br>
will allow us to use this pattern not only for the IEC cases.<br>
<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; elif [ &quot;$1&quot; =3D &q=
uot;secure-boot&quot; ]; then<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; grep -A 1 &quot;parameters&quot; &quot;$LAVA_TEMPLATES/=
secureboot_template.yml&quot; &gt;&gt; &quot;${job_dir}/${1}_${2}.yml&quot;=
<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; else<br>
&gt; diff --git a/tests/templates/IEC_template.yml b/tests/templates/IEC_te=
mplate.yml<br>
&gt; index 92944da..c8efe40 100644<br>
&gt; --- a/tests/templates/IEC_template.yml<br>
&gt; +++ b/tests/templates/IEC_template.yml<br>
&gt; @@ -60,7 +60,7 @@ actions:<br>
&gt;&nbsp; # TEST_BLOCK<br>
&gt;&nbsp; - test:<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; timeout:<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; minutes: 40<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; minutes: ${IEC_TEST_TIMEOUT_MINU=
TES}<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; definitions:<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; - repository: <a href=3D"https://g=
itlab.com/cip-project/cip-testing/cip-security-tests.git">
https://gitlab.com/cip-project/cip-testing/cip-security-tests.git</a><br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; from: git<br>
<br>
Jan<br>
<br>
-- <br>
Siemens AG, Foundational Technologies<br>
Linux Expert Center<br>
</div>
</span></font></div>
</body>
</html>

--_000_OSCPR01MB1483849AD6A77BF9A11D936CAC2BD2OSCPR01MB14838jp_--


