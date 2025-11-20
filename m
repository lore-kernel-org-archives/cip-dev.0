Return-Path: <adithya.balakumar@toshiba-tsip.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E078CF64B6
	for <webhook@archiver.kernel.org>; Thu, 20 Nov 2025 04:57:23 +0000 (UTC)
Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.158])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.27448.1763614636540817377
 for <cip-dev@lists.cip-project.org>;
 Wed, 19 Nov 2025 20:57:17 -0800
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: toshiba-tsip.com, ip: 210.130.202.158, mailfrom: adithya.balakumar@toshiba-tsip.com)
Received: by mo-csw.securemx.jp (mx-mo-csw1122) id 5AK4vFl63245551; Thu, 20 Nov 2025 13:57:15 +0900
X-Iguazu-Qid: 2rWgIwSDDX2uJKwuXN
X-Iguazu-QSIG: v=2; s=0; t=1763614634; q=2rWgIwSDDX2uJKwuXN; m=MKI3XJTM89TpbgW0wKKjk0xUpTj7sdOoBxtMfB8Yo4s=
Received: from imx2-a.toshiba.co.jp (imx2-a.toshiba.co.jp [106.186.93.35])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	 id 4dBmL25Wwcz4vyh; Thu, 20 Nov 2025 13:57:14 +0900 (JST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=v2ZfG8jXW83KfcYaXWBKbZ/ZuWyXvbdNqHuyBi4RNIrGYC+PKvpOtSb3JBEJeqQvZvBl9x22adORBXEx+5rHIfHaERLsk8pe3mN9KXjbaf6xztVtHqMSrdcpFVFPLJB5Y35SPF6wYCxJAPStc89x851QzM7rk6svu2vFShHvqAdpJMwgZaYfjcMh9fs6qT3Wm7wrTadzLG06//x4WNAZT14/lZwEXvuIl5ij2Jf5te0UJqwomOm5sCTbWyMREEbzoQTEV+znmmYZNFCtIKFQqAoWcKqMeAFvCq+nHlWjz5X4odDX+72Xkvj3y7Kh0+il03McoTVwCqsQ20LlR2lOFA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=G+Zzj/4pc5ISGDbSkPpAMgxDa5kM79XHgSh+rW3ffuM=;
 b=UIFLAvD7N6PIp+DMxiALW9SIBAeoE4AcdjlxkQxPtSDAt+e0J035vDdehC7FxGcJDfBnNDmTkl5m4dpq1LkwGYUXsOEvjAltCyaIEj95ixn1T4EwEWkRkI53P+LOoAkB4MYJui1AGMOxOV/2cytEPPxRJZstPF01tFQjZrzThAPlgHUsbacyTZkKB2AfuTTdZUQ7l/QvP8M61t5/zPBsXJohFy1xNEF46yKs7YJM67uWCHlzjjYD/uDoZBcRusDtfyoP24hijt4ja7UdoI6Qorya3MAudB8x+P1WedDANqyM1C5h1HoA4A+aVGMbo4NXCp/6Iu9MQvXm4V4KEfgKNQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=toshiba-tsip.com; dmarc=pass action=none
 header.from=toshiba-tsip.com; dkim=pass header.d=toshiba-tsip.com; arc=none
From: <Adithya.Balakumar@toshiba-tsip.com>
To: <cip-dev@lists.cip-project.org>, <jan.kiszka@siemens.com>
CC: <Shivanand.Kunijadar@toshiba-tsip.com>, <dinesh.kumar@toshiba-tsip.com>,
        <kazuhiro.hayashi.f74@mail.toshiba>
Subject: Re: [cip-dev] [isar-cip-core][PATCH v1] IEC_template.yml: Update IEC
 layer tests revision
Thread-Topic: [cip-dev] [isar-cip-core][PATCH v1] IEC_template.yml: Update IEC
 layer tests revision
Thread-Index: AQHcWdkuM7KuESCgP0aO/DeONj1+jLT6/s67
Date: Thu, 20 Nov 2025 04:57:09 +0000
X-TSB-HOP2: ON
Message-ID: 
 <TYCPR01MB9669D111DB514FEE01D4698BC4D4A@TYCPR01MB9669.jpnprd01.prod.outlook.com>
References: <18799DC70535032E.1423420@lists.cip-project.org>
In-Reply-To: <18799DC70535032E.1423420@lists.cip-project.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=toshiba-tsip.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYCPR01MB9669:EE_|TY7PR01MB14687:EE_
x-ms-office365-filtering-correlation-id: d1f4bcf1-c5ed-4e6d-d4bb-08de27f142d4
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: 
 BCL:0;ARA:13230040|366016|376014|1800799024|38070700021|7053199007|8096899003|13003099007|95630200002;
x-microsoft-antispam-message-info: 
 =?iso-2022-jp?B?T3c0am5yUjFUeHY0NG5PcWFwMDUyck9mMXZFeFJzdjliVlVDQmlBbGQr?=
 =?iso-2022-jp?B?TkxrbXUxNzE4Y3p6Y1ZqU2lFTGpwR1kvNElUQ1paNE81RElidE5OOTgw?=
 =?iso-2022-jp?B?a1RHRTFLeUYrMFFtN1Q5OUo1Tm9VdFNxcDJpdkZML3BiamxGOXhLVFpR?=
 =?iso-2022-jp?B?WjVJT2NDcDllSllIaUdsSWhqRFZieG92OHkrZzMzekIzKzdwdlZld0FQ?=
 =?iso-2022-jp?B?bm55STlHSmRBRHhPQTE1bXBxOW5tSjYvT2JtYm9hekYvYWdMVXo4L1hU?=
 =?iso-2022-jp?B?SlkyRS9xZ0N4TXk2LzV2cHQzMmFqZk9GOHRSanB2VnhxWG1NLzVXQndX?=
 =?iso-2022-jp?B?K3N5dDJXcDRZVGljclhlWFA5KzRnaFZBNGRPTTN2YXZIVkFzcWxXOHJj?=
 =?iso-2022-jp?B?WXFUNmF2dTB4RTlSN2JLaU1xN0FhL3pkN3M0REtwdUlTLzU3UDJDYkFK?=
 =?iso-2022-jp?B?SDIrZHRxeVdkL2wwQWV1MUtTc3RIczJDNDlkUDdEdnVsSy9SQTVVWFdJ?=
 =?iso-2022-jp?B?SkQzZWJzamRQM0piRkQ0YnJ5MEl4b3RyTTYyZFZwOUVGMGtTTng5RTZn?=
 =?iso-2022-jp?B?cjczL3c2R2xETEpPNXlhdktCSTQxbTY3RC9ORVZydFVOMUpVRnlmT2Y3?=
 =?iso-2022-jp?B?WWxNSm5hVWJyYitRakI3WW9vQTdEcjhVUUJWRUEzREJwZGRUV2RxRVIz?=
 =?iso-2022-jp?B?dFJXb3hMV0I3QXFydUJSaGFsR2NTU2xwc2I0cGk2amQ4ZVViZFVSRzVp?=
 =?iso-2022-jp?B?Nm1aV1hiNkNjS3JZZGczTnZOQ0pxQkpkVjFaM1RuZTZFSU5jQjA0VlNR?=
 =?iso-2022-jp?B?ek54QXJScU0wK3c4MFROSXB5T2ZyZXNXMEZ2c2NsRjRsMXFsbCtEakMr?=
 =?iso-2022-jp?B?aDZuR04zZTlwVjZhcHpOaHFHZThmV2JEY0w2WXFXamFqK0dLUjZCbkdm?=
 =?iso-2022-jp?B?anhoVyt5a2hpTjFISngxQW1wWnl0WGFtNlk0SjVsTkEvWTdmbU1LYktq?=
 =?iso-2022-jp?B?eWRHb2NnSmRJZ1FxOGtJRXcvTm9kblYwTDI0WHN0K2NhOTgrbXRWcnE3?=
 =?iso-2022-jp?B?U2ZoeHF4WURUZEpkN201Vk9iL3dIMUNDZzcrZlFpaE9BYWpvNlJYbk5s?=
 =?iso-2022-jp?B?MlA5alZJbXNKWHIvTWlGL1YxcFlObDZPVVJUNHY2cDI5V3NzeDBCUjJk?=
 =?iso-2022-jp?B?TDhtbW1YeXRXb2F1QmhTSERWVVhtL09FYTcvQ3huWmU1YnJVSzUrTU5x?=
 =?iso-2022-jp?B?c21aYTBqMnpBc2hlb2V6eTRYamFpeG94ME1Uc2I5ZkpMd2ZmUzhheis1?=
 =?iso-2022-jp?B?Z0Z2dTF6MnZVNmhzdWdsaDl4U1lvdUo1QXZtUWVhemlGK1R6czVZQzJW?=
 =?iso-2022-jp?B?WnhVZkxHc3VsenI1ekxuSGREcVBjSVNUN2VleTg1M0VscTdpVHJDMWdu?=
 =?iso-2022-jp?B?ajBEeERxU0JFR1dqd1J6YXpVZERuVVl3RnBSYnFUWlJoYnpsYnRCdVJy?=
 =?iso-2022-jp?B?dXIvdmtqUDFIZGhHcVVMdm90QnB0Ym5ER2RzSDJWNXpPRUNVVnUvSmtp?=
 =?iso-2022-jp?B?TDJGbG8yMlpDcWwyODk0YkY4YXdBV2ZsdmJyYWhqUHRocFJlNm5Lc1Zp?=
 =?iso-2022-jp?B?cHBCdkQ2SU92aXZBanFMbDhJZDg1QUE5NlIvYVIydHAxdkZBOTJmQytX?=
 =?iso-2022-jp?B?MWhUczhWRjYrTWVyVFlSRmJwSDFQVHdWQ3pzRWFaZktJTHRqUXJrRVJH?=
 =?iso-2022-jp?B?aCtzSDdEampsUllZVWduNndDWjVsWExLTFdBMW9KKzFjcC9aTVVUblQr?=
 =?iso-2022-jp?B?U0RKMzZIWG5UUGtkRkMvaDRNdndGNFdacVM1aG52Ry9JMHdIUWFVd0oy?=
 =?iso-2022-jp?B?U3lWRjBmaGdhbk9Dd3dsNkVlVWFaM0ppTlF4Y056SWE4dzdjUldUZ05M?=
 =?iso-2022-jp?B?UTk2NzZrOVY2cnBsTCsyRDVoSGUwQjg2UjE3Qk5yeEFkRXBpV2NnSXNS?=
 =?iso-2022-jp?B?d2dpa29lUkJZR2dSQnVZWjNSbFpKRlFXSFBCTGJmOHlDSm43eUw5K2ZT?=
 =?iso-2022-jp?B?c1EvcGJZMEhvdkxDRGE1clgxa0RIUEROQlUwZDA1NjNYYmRoc0t0Vktx?=
 =?iso-2022-jp?B?M2hNTnlvelYrR2w4NjN5YUUyUHZFNzN0OGhqSENaR3g4UkZWRVdTVDF0?=
 =?iso-2022-jp?B?WnR4a0JOL0pqVnJ5VVBtSXdoZEM4L0xUYU5NVVloZGs1OTBSdkFSVFZI?=
 =?iso-2022-jp?B?b21KcTh5MFZoSk0xUUVSZnRPM3BRKzU0UT0=?=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:ja;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYCPR01MB9669.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(38070700021)(7053199007)(8096899003)(13003099007)(95630200002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?iso-2022-jp?B?amw5VmVqRGF6QUhrVUpXa1Y2Q2Rnd0c1STk2NkpJV1k3NmU1Q0gwbkFZ?=
 =?iso-2022-jp?B?YUVWOEpoUWJaa3UyWC9wWmEwZ2s4Um1IaG1FWW9Xb1pRUk83eDRBRWpV?=
 =?iso-2022-jp?B?Mnd6RCthcTRnRFlReDR1RFdESndjY1plelVrcHZ4UnJQY29IZ3FyVC9n?=
 =?iso-2022-jp?B?WUEwV1JMdzVVZ2FPa0V3KzhEYllwMDJDTjlJOU1aL2VIVDdaclhZdHgy?=
 =?iso-2022-jp?B?U29nWnc3dlFCdHlralIxY3JRWE0vcG1UbnJEbS9jN0tKMUo0VXlIbVhZ?=
 =?iso-2022-jp?B?YWdud3o5WHdRcVdCWUYremVKUExRVFFXNGNtbmR3Ymg4RXNFWEpFeHhZ?=
 =?iso-2022-jp?B?WUtvOEZwazRKRlJ2ekdoL2VrWlRkTEY0OWJaR0JhaHQwZEJNckRJdCtv?=
 =?iso-2022-jp?B?RUFWbUJoa2x2RWhEVEtlQzl4L3ZxcWlCVjZ5ZTdqME9YNFcwZ042c0tI?=
 =?iso-2022-jp?B?SngyTXArRjFrTEo0Ymd2VnlFWExWejZrWFBMeEtRMkkwaTRiV2FWdk5M?=
 =?iso-2022-jp?B?MXl2Nlc3czRVbkJtelh0QXlIalVMM3FoN3JBc3UxTXM1MmViK2N2Wjgv?=
 =?iso-2022-jp?B?ZDliSWZCVWlTeHprdVNSaW4rVko0SzE4L3FKWEtaL292RENDRTdVN2o0?=
 =?iso-2022-jp?B?Q284OUh1WEdtbVl4WlQxNGFzVTlweWVrelhUTWNIVUNGeGQ1NElXYWZO?=
 =?iso-2022-jp?B?ZGV0d0N3MUUwcDJaZ3JSQ0FpdC9nSjJ1ZlFKM1FhOXR4L3FPNkdoVHpv?=
 =?iso-2022-jp?B?NlBNbTZUd2U0QVRLRVFtRVllQlBoSlpzM3p5MCtDV3RSYlRqUmpNUVRX?=
 =?iso-2022-jp?B?OE9vZFZXL1M3NGRSbXN0ayt3Nlc4aTA2UVJXc0tvaXhHdG95QW9HL2hQ?=
 =?iso-2022-jp?B?c0hiNnBacHQwdEVsdGJYQVIvNXQveFJDR3ovbXpWQ3JUck93OTRKeE1n?=
 =?iso-2022-jp?B?MkJQZloyU1d5UExUZ2xlczcvb2Y2Nlk0YWNPMnE2dFUyNDJCenhaMktj?=
 =?iso-2022-jp?B?OEJHZDFZcG1YblRSaHdjaEdRWVE0c0pvcFdyam5rcXJtbWJMNUhpajNQ?=
 =?iso-2022-jp?B?UFYrVEl5RFJ3NkRIMlZ0bVQ4Y1BEdXg0bjc0ZWsxczJlaUczSjdWaTdm?=
 =?iso-2022-jp?B?cUdNYkJMUlZXcUFBbHEvZTVySmFwZGJ0NEVzbnAzNlNNYlNWaURmYi85?=
 =?iso-2022-jp?B?QXpSTEh4LzRybmNzSnNPT3I2cUhPOE5Fb0xvQXpaZTN6Nm0xMDEvMDNv?=
 =?iso-2022-jp?B?QWFSZVlMeGR6Q1UxaDFkb3JwTzBGRDJ1QUZjcStBQ2JpZ2VSd0krZ1lp?=
 =?iso-2022-jp?B?VlFuYksxWTl1Um1zamZ3cTBFeWdxcUZEQ3FBMlJ4QmVjNmY2RjVDWkJO?=
 =?iso-2022-jp?B?d0dlb1ZGR3g2aWRzRTI4SjFHZ3E0dEZ1K0JZRVhMdkY0QUFFdm9IdkM0?=
 =?iso-2022-jp?B?M1IyYjVIUDBxdE1URkFqT2RleFUxMzNLVXhaVEZRNHB6M3ludDNVY3Bt?=
 =?iso-2022-jp?B?bmtWaTJXelZKdmVGbUFnSERSNStjdHNrWUQ0M25Pcm5NU0JSek9UZmla?=
 =?iso-2022-jp?B?a0poVWFtbUlhMnJ6WTVGVGhuRWtUR3AxZnpFRXJLYU5GbVIxRDhOelVP?=
 =?iso-2022-jp?B?d3RFcCtUZEI3cit0UGtMWUxaU2UzRVcvUVFMVndmM0NWUUZXcklYVUx0?=
 =?iso-2022-jp?B?TncxQ0lqREhoNWRIODV6and2eENyZ2VURE02VzVGekFMemxSUzhROGww?=
 =?iso-2022-jp?B?NC8zY1hEVzRuWklDeWRFZnl1VmdGNlQwN0taUUt2a3Q0d0FwclFUcDZQ?=
 =?iso-2022-jp?B?ZnVEU29rd1ZrYVE3ZVlocXdyZkRzNkhNZkUxa1BvRXUybTNLa0NmYmVh?=
 =?iso-2022-jp?B?UWJhL095aG4ySzg5bk16ZytCdm81Y0tZWjJEaWN0aXJ3Q3Jhd2VSU1R1?=
 =?iso-2022-jp?B?V3hqODZCUnNQaVdTRlVLeXF0dFJUL0F2WkREcDF0THBuUHQzckZCQ3hK?=
 =?iso-2022-jp?B?UXNRTHJHZlQ3OUUvMk5rcEpxSDNmZkN0T2k4M256dzRNZGZPbVlkYkFI?=
 =?iso-2022-jp?B?cmFFVjRzOXhWaFdmanNHOHQ1TWZtWkNxcE1paFhYNVRzTHdzcjgvT0dx?=
 =?iso-2022-jp?B?MG1UMzAvQW9iN1Rja0tjdDF4bERnRUIvQUNuQkpmZTgrbElseTFJL1Mz?=
 =?iso-2022-jp?B?QVNYenRUQml5d1NVZXNMK0VNNUMvRXQ0cHRnMUY3TXZBb0J0NlFQM2pu?=
 =?iso-2022-jp?B?K1FTOUhicEZxNnZkZ3RVTENjaHhzeEFRSUtBbytxdStBUzZzYkRYV3dC?=
 =?iso-2022-jp?B?L0JjdzlMVmpGam1JdFhYV0d5aDl3c3FzakE9PQ==?=
Content-Type: multipart/alternative;
	boundary="_000_TYCPR01MB9669D111DB514FEE01D4698BC4D4ATYCPR01MB9669jpnp_"
MIME-Version: 1.0
X-OriginatorOrg: toshiba-tsip.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYCPR01MB9669.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d1f4bcf1-c5ed-4e6d-d4bb-08de27f142d4
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Nov 2025 04:57:09.3834
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f109924e-fb71-4ba0-b2cc-65dcdf6fbe4f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: vzzKqJQFq9yk4c4P9S/IPBrMMvSVONdgG9Qgmrzcv6hz4G5F2TmVITnNJAocd43gM2lroVJgBubHvVbNz4t2M6vCIibvJP2cZgJLzC6wFodRJE0/J5db6EM4HJY3GlEV
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY7PR01MB14687
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 20 Nov 2025 04:57:23 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/20631

--_000_TYCPR01MB9669D111DB514FEE01D4698BC4D4ATYCPR01MB9669jpnp_
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable

Hi Jan,

Here's the test pipeline [1] with this patch applied.  Although I do not se=
e issues with the IEC test that this patch fixes, but I do see that the qem=
u-arm-IEC test [2] repeatedly fails (no luck with retries).

I did have a look at the failing tests and it turns out that the 4 failing =
tests are all related to the Audit feature. Let me create an issue in isar-=
cip-core for this to discuss further.

[1] https://gitlab.com/cip-project/cip-core/isar-cip-core/-/pipelines/21673=
81921
[2] https://gitlab.com/cip-project/cip-core/isar-cip-core/-/jobs/1215214238=
2

Regards,
Adithya Balakumar
________________________________
From: cip-dev@lists.cip-project.org <cip-dev@lists.cip-project.org> on beha=
lf of Adithya Balakumar <Adithya.Balakumar@toshiba-tsip.com>
Sent: Thursday, November 20, 2025 10:20 AM
To: cip-dev@lists.cip-project.org <cip-dev@lists.cip-project.org>; jan.kisz=
ka@siemens.com <jan.kiszka@siemens.com>
Cc: balakumar adithya(=1B$B#T#S#I#P=1B(B =1B$B#D#I#T#C!2#D#I#T=1B(B-=1B$B#O=
#S#T=1B(B) <Adithya.Balakumar@toshiba-tsip.com>; kunijadar shivanand(=1B$B#=
T#S#I#P=1B(B DITC_DIT-OST) <Shivanand.Kunijadar@toshiba-tsip.com>; sai.sath=
ujoda@toshiba-tsip.com <sai.sathujoda@toshiba-tsip.com>; dinesh kumar(=1B$B=
#T#S#I#P=1B(B DITC_DIT-OST) <dinesh.kumar@toshiba-tsip.com>; hayashi kazuhi=
ro(=1B$BNS=1B(B =1B$BOB9(=1B(B =1B$B""#D#I#T#C!{#C#P#T=1B(B) <kazuhiro.haya=
shi.f74@mail.toshiba>
Subject: [cip-dev] [isar-cip-core][PATCH v1] IEC_template.yml: Update IEC l=
ayer tests revision

From: Adithya Balakumar <Adithya.Balakumar@toshiba-tsip.com>

This revision update fixes the inconsistency with the IEC CR 7.1 test.

Currently the rate limit using nftables is set to 3 requests/second and
the ping flood transmits a packet every 0.3 seconds i.e 3.3 packets / secon=
d

Although this is theoretically over the rate limit and should drop packets,
but the rate limit set and the ping requests interval is too close and some
iterations can lead to no packets being dropped and thereby the test failin=
g.

The fix increase the frequency in the ping flood attack which would lead to
more packets being dropped by the kernel.

Signed-off-by: Adithya Balakumar <Adithya.Balakumar@toshiba-tsip.com>
---
 tests/templates/IEC_template.yml | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tests/templates/IEC_template.yml b/tests/templates/IEC_templat=
e.yml
index fe4132d..fba7544 100644
--- a/tests/templates/IEC_template.yml
+++ b/tests/templates/IEC_template.yml
@@ -64,7 +64,7 @@ actions:
      definitions:
      - repository: https://gitlab.com/cip-project/cip-testing/cip-security=
-tests.git
        from: git
-       revision: dee76c8b6612439ac648fd18709088ec8fea7e40
+       revision: deec0428624e827a9d762eccc99b55ee05b440fd
        path: iec-security-tests/Singlenode-TestDefinition.yaml
        name: Security-Testcases

--
2.39.5



--_000_TYCPR01MB9669D111DB514FEE01D4698BC4D4ATYCPR01MB9669jpnp_
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
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 11pt; color: rgb(0, 0, 0);" clas=
s=3D"elementToProof">
Hi Jan,</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 11pt; color: rgb(0, 0, 0);" clas=
s=3D"elementToProof">
<br>
</div>
<div style=3D"text-align: left; text-indent: 0px; line-height: 1.25; margin=
: 0px; font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, Calibri=
, Helvetica, sans-serif; font-size: 11pt; color: rgb(0, 0, 0);" class=3D"el=
ementToProof">
Here's the test pipeline [1] with this patch applied.&nbsp; Although I do n=
ot see issues with the IEC test that this patch fixes, but I do see that th=
e qemu-arm-IEC test [2] repeatedly fails (no luck with retries).</div>
<div style=3D"text-align: left; text-indent: 0px; line-height: 1.25; margin=
: 0px; font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, Calibri=
, Helvetica, sans-serif; font-size: 11pt; color: rgb(0, 0, 0);" class=3D"el=
ementToProof">
<br>
</div>
<div style=3D"text-align: left; text-indent: 0px; line-height: 1.25; margin=
: 0px; font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, Calibri=
, Helvetica, sans-serif; font-size: 11pt; color: rgb(0, 0, 0);" class=3D"el=
ementToProof">
I did have a look at the failing tests and it turns out that the 4 failing =
tests are all related to the Audit feature. Let me create an issue in isar-=
cip-core for this to discuss further.</div>
<div class=3D"elementToProof"><br>
</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 11pt; color: rgb(0, 0, 0);" clas=
s=3D"elementToProof">
[1] <a href=3D"https://gitlab.com/cip-project/cip-core/isar-cip-core/-/pipe=
lines/2167381921">
https://gitlab.com/cip-project/cip-core/isar-cip-core/-/pipelines/216738192=
1</a></div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 11pt; color: rgb(0, 0, 0);" clas=
s=3D"elementToProof">
[2] <a href=3D"https://gitlab.com/cip-project/cip-core/isar-cip-core/-/jobs=
/12152142382">
https://gitlab.com/cip-project/cip-core/isar-cip-core/-/jobs/12152142382</a=
><br>
<br>
Regards,</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 11pt; color: rgb(0, 0, 0);" clas=
s=3D"elementToProof">
Adithya Balakumar<span style=3D"font-family: Calibri, Arial, Helvetica, san=
s-serif; font-size: 12pt; color: rgb(0, 0, 0);"><br>
</span></div>
<hr style=3D"display: inline-block; width: 98%;">
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
<b>From:</b>&nbsp;cip-dev@lists.cip-project.org &lt;cip-dev@lists.cip-proje=
ct.org&gt; on behalf of Adithya Balakumar &lt;Adithya.Balakumar@toshiba-tsi=
p.com&gt;<br>
<b>Sent:</b>&nbsp;Thursday, November 20, 2025 10:20 AM<br>
<b>To:</b>&nbsp;cip-dev@lists.cip-project.org &lt;cip-dev@lists.cip-project=
.org&gt;; jan.kiszka@siemens.com &lt;jan.kiszka@siemens.com&gt;<br>
<b>Cc:</b>&nbsp;balakumar adithya(=1B$B#T#S#I#P=1B(B =1B$B#D#I#T#C!2#D#I#T=
=1B(B-=1B$B#O#S#T=1B(B) &lt;Adithya.Balakumar@toshiba-tsip.com&gt;; kunijad=
ar shivanand(=1B$B#T#S#I#P=1B(B DITC_DIT-OST) &lt;Shivanand.Kunijadar@toshi=
ba-tsip.com&gt;; sai.sathujoda@toshiba-tsip.com &lt;sai.sathujoda@toshiba-t=
sip.com&gt;; dinesh kumar(=1B$B#T#S#I#P=1B(B DITC_DIT-OST)
 &lt;dinesh.kumar@toshiba-tsip.com&gt;; hayashi kazuhiro(=1B$BNS=1B(B =1B$B=
OB9(=1B(B =1B$B""#D#I#T#C!{#C#P#T=1B(B) &lt;kazuhiro.hayashi.f74@mail.toshi=
ba&gt;<br>
<b>Subject:</b>&nbsp;[cip-dev] [isar-cip-core][PATCH v1] IEC_template.yml: =
Update IEC layer tests revision
</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
<br>
</div>
<div style=3D"font-size: 11pt;">From: Adithya Balakumar &lt;Adithya.Balakum=
ar@toshiba-tsip.com&gt;<br>
<br>
This revision update fixes the inconsistency with the IEC CR 7.1 test.<br>
<br>
Currently the rate limit using nftables is set to 3 requests/second and<br>
the ping flood transmits a packet every 0.3 seconds i.e 3.3 packets / secon=
d<br>
<br>
Although this is theoretically over the rate limit and should drop packets,=
<br>
but the rate limit set and the ping requests interval is too close and some=
<br>
iterations can lead to no packets being dropped and thereby the test failin=
g.<br>
<br>
The fix increase the frequency in the ping flood attack which would lead to=
<br>
more packets being dropped by the kernel.<br>
<br>
Signed-off-by: Adithya Balakumar &lt;Adithya.Balakumar@toshiba-tsip.com&gt;=
<br>
---<br>
&nbsp;tests/templates/IEC_template.yml | 2 +-<br>
&nbsp;1 file changed, 1 insertion(+), 1 deletion(-)<br>
<br>
diff --git a/tests/templates/IEC_template.yml b/tests/templates/IEC_templat=
e.yml<br>
index fe4132d..fba7544 100644<br>
--- a/tests/templates/IEC_template.yml<br>
+++ b/tests/templates/IEC_template.yml<br>
@@ -64,7 +64,7 @@ actions:<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; definitions:<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; - repository: <a data-auth=3D"NotApplicable"=
 class=3D"OWAAutoLink" id=3D"OWAa74c1581-c843-1b0f-07e8-a494cb31dc1e" href=
=3D"https://gitlab.com/cip-project/cip-testing/cip-security-tests.git">
https://gitlab.com/cip-project/cip-testing/cip-security-tests.git</a><br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; from: git<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; revision: dee76c8b6612439ac648fd18709=
088ec8fea7e40<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; revision: deec0428624e827a9d762eccc99=
b55ee05b440fd<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; path: iec-security-tests/Singlen=
ode-TestDefinition.yaml<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; name: Security-Testcases<br>
&nbsp;<br>
--<br>
2.39.5<br>
<br>
<br>
</div>
</body>
</html>

--_000_TYCPR01MB9669D111DB514FEE01D4698BC4D4ATYCPR01MB9669jpnp_--


