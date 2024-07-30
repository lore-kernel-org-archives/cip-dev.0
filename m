Return-Path: <chris.paterson2@renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC296C3DA70
	for <webhook@archiver.kernel.org>; Tue, 30 Jul 2024 13:49:20 +0000 (UTC)
Received: from TYVP286CU001.outbound.protection.outlook.com (TYVP286CU001.outbound.protection.outlook.com [52.101.125.15])
 by mx.groups.io with SMTP id smtpd.web10.17770.1722347352613292045
 for <cip-dev@lists.cip-project.org>;
 Tue, 30 Jul 2024 06:49:13 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@renesas.com header.s=selector1 header.b=KEWYqgQH;
 spf=pass (domain: renesas.com, ip: 52.101.125.15, mailfrom: chris.paterson2@renesas.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VR3a9pZjthvHQ7ePDzMyNrg3EdWzwaeDHX/q3A39E4WCt4OeHKA0m47WZeVvC8dfcJP8ztW17UU1XIy7K1aZFjJ79eRTXdIYC+Jx0uPAgMhG5vyy3TqaRaqv63CKPdhuO/tcs2DseGQxLuXGWvtQwp4SshfG+qwwr6NTLsrxfvVrevcFJgHCTvpwqVbf95B8BgcT2IKOL7becQVcchE7C03CFdNGXvRjpX83nsvoWQDGzYaWgb3U0zdUIsmIMQIqtkZKDZ044hwfxvyp2hO/XpZmTFxmBTfVumFgt5EV0LQMiCMq6b9wn9XIeJrklUop3t6tnrPeRUYcsxScj0eI8A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=svRgSkCtjJ4G1jU8FmnRVIZbvdoz2+fn8aVs1FODxLc=;
 b=C6BtS42EuVrGmueWuIsT4kw9peMQhQAmftR5rEpuEAb2tzMHb5gewRvXRKmqCT6JtE5mtiTk8z6AyJ8RJv0hsn5W14T3TnUgBEWdj0QyyG8pu/mQWwZniQGEtgZxf0lpWCOhpdyBNAeRA7PQIUXmfsQtHDmgz32xYaUWqRUaTRHcHdeH/HoCh3sB3Jotvt/T4OqHqplf9+mP191d/i8Z8g0RwbNFRvBrMwWWhe5v95H5Dngio7q7ze40YXVw1DfFBFdtGvvg0qpjT458K+3lDav0lVLVl+IPZf33IJCX0QCe+sS1uR+R1MH53pftYPbQGrkLahKag1/+Q8H00tkf4Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=renesas.com; dmarc=pass action=none header.from=renesas.com;
 dkim=pass header.d=renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=svRgSkCtjJ4G1jU8FmnRVIZbvdoz2+fn8aVs1FODxLc=;
 b=KEWYqgQHwGETzx8+eaKYG6YiToLUlvr8YMK/fQ47Lsp8CzXpf/OkSZ2AiSof1EyRt1XDUg0wrhlFIIWNnDbjr75WLxArzymzUFs05QLTpIzh0AID943kFKlg+lwNwwLDlhn19NH/zA6b/ims3AIUx5WcfYodkhDe4FNym8N5gnw=
Received: from TYYPR01MB12402.jpnprd01.prod.outlook.com (2603:1096:405:f7::12)
 by TYCPR01MB6995.jpnprd01.prod.outlook.com (2603:1096:400:be::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7807.28; Tue, 30 Jul
 2024 13:49:08 +0000
Received: from TYYPR01MB12402.jpnprd01.prod.outlook.com
 ([fe80::64e8:dbea:c288:5e87]) by TYYPR01MB12402.jpnprd01.prod.outlook.com
 ([fe80::64e8:dbea:c288:5e87%6]) with mapi id 15.20.7807.026; Tue, 30 Jul 2024
 13:49:07 +0000
From: Chris Paterson <Chris.Paterson2@renesas.com>
To: "Sai.Sathujoda@toshiba-tsip.com" <Sai.Sathujoda@toshiba-tsip.com>
CC: "cip-dev@lists.cip-project.org" <cip-dev@lists.cip-project.org>,
	"jan.kiszka@siemens.com" <jan.kiszka@siemens.com>
Subject: RE: Sporadic failures of swupdate tests
Thread-Topic: Sporadic failures of swupdate tests
Thread-Index: AQHa3oxAzZtSl/BbV02mWx2BKqmCqrIHagjqgABzooCAB3IvkA==
Date: Tue, 30 Jul 2024 13:49:07 +0000
Message-ID: 
 <TYYPR01MB124024682FB394D8028018049B7B02@TYYPR01MB12402.jpnprd01.prod.outlook.com>
References: <93e132c8-3229-434b-98ce-169138889a38@siemens.com>
 <OS3PR01MB6103DECD8546D119F436938FC2AB2@OS3PR01MB6103.jpnprd01.prod.outlook.com>
 <OS3PR01MB6103DC424B825831970AA3F9C2AB2@OS3PR01MB6103.jpnprd01.prod.outlook.com>
 <TYYPR01MB12402D59452F7EA25A8DE10D7B7AB2@TYYPR01MB12402.jpnprd01.prod.outlook.com>
 <OS3PR01MB61039127C5BDFEAD794823B0C2AB2@OS3PR01MB6103.jpnprd01.prod.outlook.com>
In-Reply-To: 
 <OS3PR01MB61039127C5BDFEAD794823B0C2AB2@OS3PR01MB6103.jpnprd01.prod.outlook.com>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYYPR01MB12402:EE_|TYCPR01MB6995:EE_
x-ms-office365-filtering-correlation-id: 50579c3f-7acd-4636-d4a5-08dcb09e623d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|376014|1800799024|38070700018;
x-microsoft-antispam-message-info: 
 =?iso-2022-jp?B?bHEwcThxM2FUQ05wdituZ3kybysvbGp2a3M0L3pTVi9zY2hZcDRaL0Zj?=
 =?iso-2022-jp?B?bW5kTHN2N1h6a3lGWHNsYkpFN1hVeTI4ZUJRdWZXdlZZemgrVjRPV2kv?=
 =?iso-2022-jp?B?S1MySzRnSVhZTEhxSElYUU1tSXNaR2craURMK1c1VWw5emw3eGpKVVIy?=
 =?iso-2022-jp?B?ZHNaQXdsYmo3N2RMTXFtWk1jd21iM2tGNU9rWVJoQjA1SThER3pkVzRv?=
 =?iso-2022-jp?B?UGNDdDFWU04ybndrZ3UrSDU5VFVheVdBUExtQThDa2lPQmNCcmNaS3RC?=
 =?iso-2022-jp?B?NmdkOHl4bFFTaVR5UVdxNEd3TjAxNm9BdnRoZVZubmFTVzRCU3Q0OU9B?=
 =?iso-2022-jp?B?TDBaVnlVK2FwOU5pSnQxM3FtK21IeGlnT3RZR2lFMVJsYi9waWdSZEhP?=
 =?iso-2022-jp?B?b3hkVmxGdUVuNTc4b3J4NmNtVkExcFNGM3EvRWJOL2h3VEJDd3BYMGw0?=
 =?iso-2022-jp?B?Y1EzS3lZR2JJZUtoRm1ETGNZVnRuajhDVU50NVRUc1MzZURKWCtHV3h0?=
 =?iso-2022-jp?B?YUxad2l4bUxaT1ZjbnhXK3Nja0FGeHBRazJtY2xiYzlIbndRenNnaW1C?=
 =?iso-2022-jp?B?blVEUlZGaWljRCtSRERZRjVWV1NsSjg2b1J1VERlQ1lYRjNjN3pvQWlu?=
 =?iso-2022-jp?B?bE5TM0E0K2RBY1JuN3NYOVBzSkcvbkp0d2hEcHhmb1lNVDVkVnR2STF6?=
 =?iso-2022-jp?B?Z3k3VkRSZ05ia1V1TkduY3dZYXd5RVpUTVdvRGcxTWxxUG1ZQUVYLzJj?=
 =?iso-2022-jp?B?bjBGTFV4Vm9CSVlTM0p3eFUycFlGZ2poVDRnZUlZbGFsNlBZUW5STHZ1?=
 =?iso-2022-jp?B?cWJOSFJzZStkV1UzRkxLcnRQUmtuUU9kNk52UHU2aXBpai9XQk5FM0th?=
 =?iso-2022-jp?B?YnhLeWl3SXB6Q2ZCVCs3QUJoVFRSTnloVklKTURqRG5kbFBXdjZIN0hJ?=
 =?iso-2022-jp?B?Nm5QU1ByZlBOUXd3bkxSa2lJc0lXYnJUUkFKOGd6OUIvbmFDK3YvL0lW?=
 =?iso-2022-jp?B?MGJGNWFpdnhZc3Fjd2tRS2JYaTIzdVpNNGNMR21NRDNHVmFRNkdxdW5i?=
 =?iso-2022-jp?B?WHhtUEFYR29hcEd4Qmo1aWxIZlJOQk5wcW1YQTNwN1NDdHhrOWszdDJG?=
 =?iso-2022-jp?B?VS9uOVoxMUR4SEEvaFdXNUJPem04VCtBQ2ltSFVvdHVWVEhqK2hvZmtw?=
 =?iso-2022-jp?B?UWFPYlFyWTVnZ2NjYytjWHd4eEtlMWU2YWVqQUhEZS84YkdOVmFvNmU4?=
 =?iso-2022-jp?B?UHhuSDBBN1B2K3RjOGlxbENYaWlPWjRkS0pLTUUwT1dpVXNQT295YVY5?=
 =?iso-2022-jp?B?Si8vWkdvUHl2TnR4WkQveC83cUVNMjdIQkRYcHY4dXUwamU4UHR0VTg1?=
 =?iso-2022-jp?B?djlackw4Z3dudlNrWVluczNvS3QybWs3UTNlTEYxaWRpZCtaZVBiN2du?=
 =?iso-2022-jp?B?VUV2enNmdTZaRmo2UzhBUGhnaTV6ZU9GQkZhZGZIem9sbVBTV0plMU9W?=
 =?iso-2022-jp?B?emtudmRBRmtDeFJXdCsvSmUrcjhuZ2krVFlJRytuYjBYUndFNG95ajRq?=
 =?iso-2022-jp?B?VnNEakdQanNySndaaXl2UWlsV2JWdTRiNUlNTkhVZ2hFWnArdmdqWWZx?=
 =?iso-2022-jp?B?SVNkZHNWMWl3RnMxVmZJanJEdE5KQzRtMkw5R0JRU3JVZmltV3ZTYUhs?=
 =?iso-2022-jp?B?VlNRbG5ENEp4RVBSb2dKaHlYMXh5R29aaFlCYUFyQmZaUFk3TDFaVmRC?=
 =?iso-2022-jp?B?NFhwamxLZjNvMDcwbkkwQlRyS1p5TkN3QmZyb3U4dTgrVGZnZ1Yxc2tN?=
 =?iso-2022-jp?B?VUU2RkJKSUVLWk1uT2h5Uno4WEZMb3J3TFBhTmRnZGE4VGhLSENHK0Va?=
 =?iso-2022-jp?B?S3pHUEFUQmVTaTRLWElsOWtpbkJaN2UzekdwYWhWdkUxRDIwTG1TVnNl?=
 =?iso-2022-jp?B?cTlHdnphREQvQ20vN0d2aXFMM1RJdmx4UllrN0dmWUlERTVneUNiZE1z?=
 =?iso-2022-jp?B?RT0=?=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:ja;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYYPR01MB12402.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?iso-2022-jp?B?Sk56dzFGR0JjYmZaVEloTmx3am9VRjIvWlZ5blN4a0hzMXhua1IvZTVq?=
 =?iso-2022-jp?B?c0syOHRFRkRhS3BTYXR5a1hXS0hFNWQyMEZhRDVXRzZyODhaYmt1Wi94?=
 =?iso-2022-jp?B?VktrUnc4L1djUDgrb0UwUjRwRUlxa29tWHlxMnRQMHJFNVJHSEUxUUtj?=
 =?iso-2022-jp?B?c3VmcEVTcm8rVDhBdFIxcGVobHVNOE1Yb0xHUnM1N0RFYVk3eHBobXlX?=
 =?iso-2022-jp?B?WnVKVm92Sm9QTlVuQnRRRE9VVnhwbitNM3lVd3MvRXQ3NDlUQXNsdkFp?=
 =?iso-2022-jp?B?UGNkMDNaQ0hBSVBhOHIrdnVkdmN1Q3hBRWVDeU1mMm9kNzUwcUo2ZGY3?=
 =?iso-2022-jp?B?REc0aXBNMGhMbWJ2Vzh6ZmNCUUNCVnliWXhWeGhGSjlMdmMyZHhDWGRS?=
 =?iso-2022-jp?B?b3ZNaVdXOEwvNHZlVGFXa3VyUnVST2JTKzhEMjh0YkwxWnUzSkg0MGpO?=
 =?iso-2022-jp?B?ZTFUYUI2emZITTJuSmVzNzg0bjc3RTRpa2pVdWNIcVljZkZjaUFhbkJB?=
 =?iso-2022-jp?B?Rkd0OU0vb0dIWDNrZWhzRmdTYS8zTmttNGQzaCtrWUJNNzhsOHk1bmMv?=
 =?iso-2022-jp?B?QXBDcDZ1cU94WG5WSjVZWUxBcUhxUWNLN3dsZjkwTWtnVDRzSkdGS1o0?=
 =?iso-2022-jp?B?b1VmNUlvSnlPQnZ0aFVENXB0WUg3TUJWaFRTcnR3a29RemtqeHVnVE1l?=
 =?iso-2022-jp?B?aS95b2hZTSt5N0Y3ZzU5eHNpcFpuMUpGODNuK05rd3gyZDZ3ZEVWZFNr?=
 =?iso-2022-jp?B?MjRXZk51UEp1cERXeWUwbUFTWEUydGxucXRNellqWkdHejJ0eXFHV2NS?=
 =?iso-2022-jp?B?c0FiVSticWRqZm1lNmhSTTZ6MjJuam1aMFIvL05hclg1NEtZTjdSQ0FI?=
 =?iso-2022-jp?B?T3p0dU5YZGdyR3dpb3M2TW9kNkRJMStJL1RjVzh1TDRVN0ZJT0EyNWpO?=
 =?iso-2022-jp?B?TFhab1FlNGw5cnZsWHFKWDlHTmVHYnNCRzM2aTFJa01GdXpsOTZrR3lk?=
 =?iso-2022-jp?B?YllqbWVudnVlT2VvTkFEZnljbHBUSlhqcVJlZnEyWFF0TFZmWlo0R1FQ?=
 =?iso-2022-jp?B?SEEwVUNBRmZZMlk2YmdWamptanliYzIzUVVLQS9QTlIzbFNpdTF5WkRq?=
 =?iso-2022-jp?B?UEEwMmFFcFNXajc1eWwzQzJzQ01hUkRwb2J5YVkvQVd4RTJ1ZnVNOGhX?=
 =?iso-2022-jp?B?TG9CS2R2NG9ib285U0xLRTBwVEpCWjQweC85cXpYVWo5K1NBL3hzbFZy?=
 =?iso-2022-jp?B?UDBtRVNvSG12UUxaSTN2d3I0UXZodnFSR2FERHRMY0JKM3BzckNMZlR3?=
 =?iso-2022-jp?B?L0NwdUpZZHI2Q3FRRUplanlPbHZkS20zWERKNTROM1pLUXhISDAxNXQ4?=
 =?iso-2022-jp?B?d0YvVDNLUiswdjEyQkRCZ2RPU3Z5SUNjNDFDRVFVcWtsWmgvNm9SckFF?=
 =?iso-2022-jp?B?Q3poODExME1ZWWlIaldFUHBuREd5OXRydkRJdE9SZE1YMkY1eFRONmJt?=
 =?iso-2022-jp?B?ZytadHdPcnVZOG1kMUF2RzVLNk9xbkwzVmgwRTRWamM2dE03YndUVFc2?=
 =?iso-2022-jp?B?OXhRRy9BTGo3VVZNaFVnaEVoRm90b0oxcUdtSFRzWkdWVmkyRnp1OWd6?=
 =?iso-2022-jp?B?YmdaZGduOE1MZVNjWmdnbU5xRWxmYW5hRXowTzVzRDZPWWNzS0ttdWdx?=
 =?iso-2022-jp?B?KzdxeDlWLzFwSi8xRFVHVGlRcGZIQTRzQ2s5bGpJNU82T3pVNnRuMmo1?=
 =?iso-2022-jp?B?M3ltTnpSeXpBV0VZamtJekNkMnRVOTQ0bUtSQlpEUVRYeEZkVzYwclQ3?=
 =?iso-2022-jp?B?S0RKWWRsRWtRbEhVbUQraWRaZllrT1NxUlZhelFwRVpTYVdLcU1wVFJu?=
 =?iso-2022-jp?B?Ujllc052ZkpIV0dtbGl2bmhXaGhkb2ROSG1kb2xCanBVZHpmTXBJQ2ky?=
 =?iso-2022-jp?B?bnBBSXl6M0lNeXpEY1RIZ2VUbjZRQkpwT0k3R0loZGg3YWg0cGpDQnRY?=
 =?iso-2022-jp?B?a3VSM3RKU2NSV1ltWVNCVEVWUTRISzRVelIxc3VpLzE3Z0k3aVAwblZy?=
 =?iso-2022-jp?B?NEdNMzhVR2ZUOFNTMHhBUW1oT1E1blBVSEJOeWlhS0xjSVJUcWNPZjU2?=
 =?iso-2022-jp?B?NXpva1FDSkdXcXppeG93RGpWeWQ1UURaaCtYZXBaSGhEYXBSaElsQUdH?=
 =?iso-2022-jp?B?ZkU0Z0IrMVk2UCtOUTJpNmJ0VS9PbXhpbjBOOG1MejRnUWkvZW5rSjd0?=
 =?iso-2022-jp?B?U0FZSkc2WEF4cXI0U1FJbWdqMTJQT2hmaWVZUXVqYVI3VUVKODNKajhx?=
 =?iso-2022-jp?B?N1dONGlKVUxRRlVJdGNwd2NwcTNDcUZEMnc9PQ==?=
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYYPR01MB12402.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 50579c3f-7acd-4636-d4a5-08dcb09e623d
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Jul 2024 13:49:07.8880
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ysE8gxEavvk3YX+//DKAB0O5oyRZmthjDZosZHeuo4gsyOoBeNAwNunN9OA7Y7Vma3rFzxB4yI8S8z0GQ+c4GwqhNenlCKUpncC5U/mvTxw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYCPR01MB6995
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 30 Jul 2024 13:49:20 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/16688

Hello Sai,

> From: Sai.Sathujoda@toshiba-tsip.com <Sai.Sathujoda@toshiba-tsip.com>
> Sent: Thursday, July 25, 2024 9:01 PM
>=20
> Hi Chris,
>=20
>=20
>=20
> The issue I have seen in my local environment is regarding TPM errors
> where sometimes I was unable to boot due to =1B$B!F=1B(Bcan=1B$B!G=1B(Bt =
decrypt /dev/sda6,
> rebooting due to panic=3Dboot argument=1B$B!G=1B(B -> https://gitlab.com/=
cip-
> project/cip-core/isar-cip-core/-/jobs/7326477318#L124
> <https://gitlab.com/cip-project/cip-core/isar-cip-core/-
> /jobs/7326477318#L124> . My local environment is not LAVA environment.
>=20
>=20
>=20
> The actual issue which I was mentioning regarding ,
>=20
> >> For example, In this job
> https://lava.ciplatform.org/scheduler/job/1164400#L1667
> <https://lava.ciplatform.org/scheduler/job/1164400#L1667> , it can be see=
n
> the system is being reset multiple times in the middle of the boot
> process, finally leading to a boot time-out error.

According to the log there's no input from LAVA at the point of reboot.
The log is all green, which is showing only the serial output from the DUT.

So perhaps the qemu machine is rebooting itself?
Or perhaps there is something wrong in the LAVA env, but it seems odd that =
it's only occurring for the rollback testing test jobs?

Have you ever seen this issue when not using the tpm or swupdate test cases=
?
We need to narrow down the specific environment where this issue is seen.

Thanks, Chris

>=20
>=20
>=20
> This issue is occurring quite a few times recently and I have never seen
> system getting reset multiple times in between boot process without any
> trigger evidence even in the logs in my local environment while working
> with CIP security target. So, I suspect it might be a bug in LAVA. Do you
> also think the same or is there is any known limitation causing this issu=
e
> ?
>=20
>=20
>=20
> Please provide your opinion.
>=20
>=20
>=20
> Thanks and regards,
>=20
> Sai Ashrith Sathujoda
>=20
>=20
>=20
>=20
>=20
> From: Chris Paterson <Chris.Paterson2@renesas.com>
> Sent: Thursday, July 25, 2024 10:32 PM
> To: ashrith sai(=1B$B#T#S#I#P=1B(B) <Sai.Sathujoda@toshiba-tsip.com>
> Cc: cip-dev@lists.cip-project.org; jan.kiszka@siemens.com
> Subject: Re: Sporadic failures of swupdate tests
>=20
>=20
>=20
> Hi Sai,
>=20
>=20
>=20
> In your email to Jan earlier you said that you've seen these issues in
> your local environment. Is this local env also a LAVA environment? Or is
> this issue also reproducible outside of LAVA?
>=20
>=20
>=20
> Thanks, Chris
>=20
> ________________________________
>=20
> From: Sai.Sathujoda@toshiba-tsip.com <mailto:Sai.Sathujoda@toshiba-
> tsip.com>  <Sai.Sathujoda@toshiba-tsip.com <mailto:Sai.Sathujoda@toshiba-
> tsip.com> >
> Sent: Thursday, July 25, 2024 1:14:43 PM
> To: Chris Paterson <Chris.Paterson2@renesas.com
> <mailto:Chris.Paterson2@renesas.com> >
> Cc: cip-dev@lists.cip-project.org <mailto:cip-dev@lists.cip-project.org>
> <cip-dev@lists.cip-project.org <mailto:cip-dev@lists.cip-project.org> >;
> jan.kiszka@siemens.com <mailto:jan.kiszka@siemens.com>
> <jan.kiszka@siemens.com <mailto:jan.kiszka@siemens.com> >
> Subject: RE: Sporadic failures of swupdate tests
>=20
>=20
>=20
> Hi Chris,
>=20
> Currently Swupdate, Secure boot and IEC layer verification jobs are
> running in CIP LAVA Lab from past 2 months. Recently there are some issue=
s
> rarely seen while booting the image where the system is being reset
> multiple times during boot process leading to a timeout error. It is not
> like that particular lava slave machine has an issue because the next job
> running on it can see successful boot. This situation is seen irregularly=
.
>=20
> For example, In this job
> https://lava.ciplatform.org/scheduler/job/1164400#L1667
> <https://lava.ciplatform.org/scheduler/job/1164400#L1667> , it can be see=
n
> the system is being reset multiple times in the middle of the boot
> process, finally leading to a boot time-out error.
>=20
> Do you have any idea about this ?
>=20
> Thanks and regards,
> Sai Ashrith Sathujoda (T S I P)
>=20
> -----Original Message-----
> From: ashrith sai(=1B$B#T#S#I#P=1B(B)
> Sent: Thursday, July 25, 2024 11:46 AM
> To: Jan Kiszka <jan.kiszka@siemens.com <mailto:jan.kiszka@siemens.com> >
> Cc: cip-dev <cip-dev@lists.cip-project.org <mailto:cip-dev@lists.cip-
> project.org> >
> Subject: RE: Sporadic failures of swupdate tests
>=20
> Hi Jan,
>=20
> I sincerely apologize for the delayed response. I observed these rare TPM
> errors even in my local machine during development and testing with
> security target even though we made sure to run one security target at a
> time on one lava slave machine to avoid any TPM related conflicts.
>=20
> Currently I do not understand why system restarted in the middle of boot
> here -> https://lava.ciplatform.org/scheduler/job/1164400#L1667
> <https://lava.ciplatform.org/scheduler/job/1164400#L1667>  and this reset
> is happening irregularly at random times during  boot.
>=20
> As of now I believe it has something to do with the state of the slave
> machine on which the test ran in that moment. I went through the list of
> all the unexpected failure jobs till now. Some of them came under 'LAVA
> Bug error' and most percentage of the failures came under the category in
> which system reset is happening right in the middle of the boot process.
>=20
> I will discuss this point with Chris, and I will let you know the issue a=
s
> soon as possible. Once again sorry for the delayed response.
>=20
> Thanks and regards,
> Sai Ashrith Sathujoda
>=20
> -----Original Message-----
> From: Jan Kiszka <jan.kiszka@siemens.com <mailto:jan.kiszka@siemens.com> =
>
> Sent: Friday, July 12, 2024 7:10 PM
> To: ashrith sai(=1B$B#T#S#I#P=1B(B) <Sai.Sathujoda@toshiba-tsip.com
> <mailto:Sai.Sathujoda@toshiba-tsip.com> >
> Cc: cip-dev <cip-dev@lists.cip-project.org <mailto:cip-dev@lists.cip-
> project.org> >
> Subject: Sporadic failures of swupdate tests
>=20
> Hi Sai,
>=20
> where are these tests actually failing? The also reporting that they are
> unable to clean up the jobs properly, but we rather seem to have TPM
> errors:
>=20
> https://gitlab.com/cip-project/cip-core/isar-cip-core/-/jobs/7326477317
> https://gitlab.com/cip-project/cip-core/isar-cip-core/-/jobs/7326477318
>=20
> Retrying them sometimes "resolves" the issue. Can you check if there is a
> way to improve reliability to avoid any false negatives? Or do we really
> have problems here?
>=20
> Thanks,
> Jan
>=20
> --
> Siemens AG, Technology
> Linux Expert Center


