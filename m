Return-Path: <chris.paterson2@renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A282C87FC9
	for <webhook@archiver.kernel.org>; Wed, 30 Jul 2025 08:01:28 +0000 (UTC)
Received: from OS0P286CU010.outbound.protection.outlook.com (OS0P286CU010.outbound.protection.outlook.com [40.107.74.57])
 by mx.groups.io with SMTP id smtpd.web11.30099.1753862480202762012
 for <cip-dev@lists.cip-project.org>;
 Wed, 30 Jul 2025 01:01:21 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@renesas.com header.s=selector1 header.b=QWX19lhh;
 spf=pass (domain: renesas.com, ip: 40.107.74.57, mailfrom: chris.paterson2@renesas.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xMed/Z/bFLAoi1Ge3Ck3bJvbg2+u3LXNfJXVQZ2teNgRq17F1Vn0k1I+JRRjqUJ4s7qd9KlBuJsarx8v+dt27veQ4mP8ZTyjvUSjksrSuu+SPodymJMKV8tWkVmm8mgNq3wkEWJRDQTOGAWISbT3bomCyMek9SjX7blYJ5APWHOevddAka6suDfW4MNr6rEIdVFx+F6KnxnoATDxqR0VSKpZjqEoxWKqaVeVTeq4ar+TaYNTldmPYXRzdSmUU1zdV0eDrij9JEJ0jC0PhCBFY/7z5jCYpTDTqxupxL3p7FhKuOpln+fpKzJ5L1Np36mDHNoUZTkZFAFg9ZlAAAqgzQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hUAGXr+KltD0ayZhwM+akCEzE8Zr8KsiZF6XznUXLU4=;
 b=WFwMyQX2OcR5y4ChkDbIFZvwKecL2FlzaY1EMbPyRaxRUpIp2B6Lr0pcsQtJFVeiQYIRbFCx175Id0atrafm7hOL+iakaoM6h+NjMrATX34ML18yVApv33FAR4ihMK9QBEIeAw+/VVB+l6488W39bw/NU/Rf/nOfDzSU1BS2jtvF80mkSUf+w7h6WxNZLvIiGkCX+DFvQtNB3aXedysRE6EgTaHgfGebqs2qdRcyDHvtE1Eonti3gAdpPyNSUtskRTEV87S+UAoLx12opqPrYLopcymHup2Tcu9VwJUdghtIZBU4kb27sfN7pEJvtbG+jJojTJLrRY1/ZIO2DSh1vQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=renesas.com; dmarc=pass action=none header.from=renesas.com;
 dkim=pass header.d=renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hUAGXr+KltD0ayZhwM+akCEzE8Zr8KsiZF6XznUXLU4=;
 b=QWX19lhhfmdfxby49SxjbIbJxZEPQExAi5/YJL9WwgbfkcbUkQgNhbuC6XZ+gCp8l7frap5YjjqmuqV3vKAEk/Zl50u6ncEx3K95kN5u9orVJuiTnwAEOjhIMGLUwlmdnHJVxvTSJXQNHiFQ4QyKsw59zwlpPPe2fB+V0+uGPw4=
Received: from TYYPR01MB15132.jpnprd01.prod.outlook.com
 (2603:1096:405:1a1::10) by TYRPR01MB12237.jpnprd01.prod.outlook.com
 (2603:1096:405:101::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8989.11; Wed, 30 Jul
 2025 08:01:15 +0000
Received: from TYYPR01MB15132.jpnprd01.prod.outlook.com
 ([fe80::3fd9:f47c:79c7:a6c6]) by TYYPR01MB15132.jpnprd01.prod.outlook.com
 ([fe80::3fd9:f47c:79c7:a6c6%4]) with mapi id 15.20.8989.010; Wed, 30 Jul 2025
 08:01:15 +0000
From: Chris Paterson <Chris.Paterson2@renesas.com>
To: "Shivanand.Kunijadar@toshiba-tsip.com"
	<Shivanand.Kunijadar@toshiba-tsip.com>
CC: "dinesh.kumar@toshiba-tsip.com" <dinesh.kumar@toshiba-tsip.com>,
	"kazuhiro3.hayashi@toshiba.co.jp" <kazuhiro3.hayashi@toshiba.co.jp>,
	"jan.kiszka@siemens.com" <jan.kiszka@siemens.com>,
	"Adithya.Balakumar@toshiba-tsip.com" <Adithya.Balakumar@toshiba-tsip.com>,
	"cip-dev@lists.cip-project.org" <cip-dev@lists.cip-project.org>
Subject: RE: File server for zchunk swupdate update
Thread-Topic: File server for zchunk swupdate update
Thread-Index: AduXPMDwGbkQ98swTHSVcGfABwDcxwFaGtzQGPn4QcAAJoF0YA==
Date: Wed, 30 Jul 2025 08:01:15 +0000
Message-ID: 
 <TYYPR01MB15132EEA4A10F3951E90237E4B724A@TYYPR01MB15132.jpnprd01.prod.outlook.com>
References: 
 <TY3PR01MB11075908DA987ADCDE33DD899C7DF2@TY3PR01MB11075.jpnprd01.prod.outlook.com>
 <OS3PR01MB58966EB75B7DC1FEB3851792B7A42@OS3PR01MB5896.jpnprd01.prod.outlook.com>
 <TY3PR01MB1107501396B71E71A49B7A7C8C725A@TY3PR01MB11075.jpnprd01.prod.outlook.com>
In-Reply-To: 
 <TY3PR01MB1107501396B71E71A49B7A7C8C725A@TY3PR01MB11075.jpnprd01.prod.outlook.com>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYYPR01MB15132:EE_|TYRPR01MB12237:EE_
x-ms-office365-filtering-correlation-id: e2acf4e6-b162-45d5-be9e-08ddcf3f41ea
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: 
 BCL:0;ARA:13230040|376014|1800799024|366016|38070700018|7053199007;
x-microsoft-antispam-message-info: 
 =?iso-2022-jp?B?aDIzM1V4UDc4QXNKb0VjejRWb2lNNVNFd1hPNGhza1ZMRkh1Qm82RjNZ?=
 =?iso-2022-jp?B?dTZsWGhnWGc0YTlZZG5JWVBaS1VwNXQrUUpUQ1RvTUw1NEErTnhRNnJV?=
 =?iso-2022-jp?B?ZC9RN3pzM3JKMTUxdjV6NVZ6ZHN0V3NPTDVia0tXNnRzNHR1ZmVQTytR?=
 =?iso-2022-jp?B?YjhpMUFWOHlmclNZVnBveTBjTDBEQytZaU1jb2RYalExemtITE94ek92?=
 =?iso-2022-jp?B?cldOdU1lcmRBNnBZWXpkNGdRN0x4WE9mR2V0TVVnVnZXOVZSWW9KUUNB?=
 =?iso-2022-jp?B?ZVYvNGx2SE5XUXVWeEhlOHU2WllzUEw5eTNJQWNXVmFjQ0dRbHZKams5?=
 =?iso-2022-jp?B?NjNFNFFZUXZHTlVJb3J0NmZyNmxkY1pOME8rTXZsTHZ0dDA5cERZc2RB?=
 =?iso-2022-jp?B?TWNRdlZYQUZ2V3ZKZ1pTSzBScEN5enJBKzdodkoyVUlZcTBXK3FZQjlJ?=
 =?iso-2022-jp?B?dTRkV2hGbEFrUzVpdlZvQ0hjUmkybHBmcWhqcE1qVjBIUmZHSy9GSnhT?=
 =?iso-2022-jp?B?QTJHRjhxL3RsSExOU0Q1ZFhPbWE0Y3RtTmFEZk5RTEluakxUS01Od2pl?=
 =?iso-2022-jp?B?Ti8wSDhLQ3hyeFV6VktQMnE2YXNEVTZKS2s0WkF1cDdKemFYdUdZSmtG?=
 =?iso-2022-jp?B?U2NtaTllTUR1c3JOSGFQZG9OcENTN3lHZGVFM3hZVlBsK0RJZ2xVT1pq?=
 =?iso-2022-jp?B?YUsxcWJaVEpRelZMRHhYR255L3F6T0tWaUZaTGZZbG5BZGh4QTVTWEZL?=
 =?iso-2022-jp?B?SVd2MlkxTUE3NlV6Wkp5VFJyZzBBOWdzbm1RWGtIRjMyYk80VGg5dlJY?=
 =?iso-2022-jp?B?QlJqS3QrWUxycXZIR0YvTE1KQ0hTRmc5MGVTVTR3Nlo5eHJ4RDBWYVYx?=
 =?iso-2022-jp?B?L1VSc2lWWjBTU0hGK2RiWDZNOExJUUxaOW8wNmNFL2M1M0dZWEFHVlJo?=
 =?iso-2022-jp?B?dWtTVmNhMUVtL0d5aDVGcXJPRk1VeHNMMERhRklCWndyb1VWaU9LemRL?=
 =?iso-2022-jp?B?RXhQTmRQV09kRFljSVFOanExa29VcFRWSXhwUjB5dGlrU05DYXU3TWFi?=
 =?iso-2022-jp?B?dE5xU1MrZ2YyUWVpSG1qMnhNK0p5cDJqL2QwajIxUDQyYURCbE9kUkQv?=
 =?iso-2022-jp?B?UG00ZW43TStlTEgvMWUyNlJQMWEyU3NFWkJtcnRpSUlhZ2xCK0VDSWRZ?=
 =?iso-2022-jp?B?OTVJb2t5OEdIdURYa0Q5THQwakp5QXYvb213WUZSaFYzbE1kZzRQY0RS?=
 =?iso-2022-jp?B?SkdjakRlZ0t2QlhQdmtzaUVoc1lmbnRRR2xJTVhCUkZyU2V3dVBWcEs3?=
 =?iso-2022-jp?B?ajB5cGJHZmppMUEvdnJqS2xUR0k0YUkvck5SbDRZM0w2Q2x2bXNKM01D?=
 =?iso-2022-jp?B?MXdSNlZQQkY5Z1JPQzJ5ODk3NUllRUlxWlpIckpZeTZQbFg0UnYwM3NI?=
 =?iso-2022-jp?B?VUJMZUpuT0h1VlpsRkZscVFud3NOa3plaFRzWk5KbHRsZU5LWXMyY0Nq?=
 =?iso-2022-jp?B?VHRwR0UzTFBrR3prdTJSZkd6OHgxeE9SV1NZd3BrMUNCditBelJ6RERu?=
 =?iso-2022-jp?B?TE9QK2tiREZMVXZPN1B2amREelcveFJOeXVmUXpmQ1Y4Yk9nT2R3U2xs?=
 =?iso-2022-jp?B?OWxoQmFRWEZLcjBsR21LWHpGWS9YeTh2UitmTkJSTysvSGtGakFmMkNr?=
 =?iso-2022-jp?B?ejUwOEFXWEFMWVgvajJ4aUJwL0tncUFVNldaNnlyZituMlYvKzFVMGMy?=
 =?iso-2022-jp?B?SmFmeEVTcHYrNkx2ZXNRQlJOYTl4VmV5NG1wZ2wrREJxc1Npd0QyeHZN?=
 =?iso-2022-jp?B?VTViWWxSR3JmWXRYRlc5VVJ2M0lZZ2VtSE8zOUIvVHg3Smk4dXkrYVpO?=
 =?iso-2022-jp?B?STVkTnRrYzQyWTQ3NGd6NkIxYlJIRjJUbTVMZ2VvTGpLYUJ2U3pUZ29i?=
 =?iso-2022-jp?B?alZaZDQ0TjVOL0pkcWpqVUpVWTJJaTAyRC9QZ0V0NnhlUkVMWXV0OEFF?=
 =?iso-2022-jp?B?MDBORmVEU3loY1ZzMTd1bzdZNHhsWmIwNVdQR04vSUhVd0hhVHhyVWsy?=
 =?iso-2022-jp?B?djZ1SnZoT1E3UDFFZjVWZXowUXRwdGc9?=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:ja;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYYPR01MB15132.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(38070700018)(7053199007);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?iso-2022-jp?B?cmdsK0huOEhWYTU1VzVxSmVSQzB4UGlKK2VtVy9iRGpwS0FUNEtwQnVL?=
 =?iso-2022-jp?B?VGF0b0poc2ZZUkdQN0I0cVBBbUpqb3hObGtQTVNxQkxWQWpReCt2eXpV?=
 =?iso-2022-jp?B?elpQemN1S1ZSU2puSmFua1J1NmJralJ0V0pEZWh1NjgrQWs4U0Y1NEdE?=
 =?iso-2022-jp?B?cDdLeUpJZkxjQVRlWXZmS0FCN1A0cTU2RXIzZnNxSkI3WmRxSVJ5TFdy?=
 =?iso-2022-jp?B?S1ZQMFExRWs1WlJmSHZFQTBRSkpCTnFma3dvcDhLMmV0L3k0QnFFQkFD?=
 =?iso-2022-jp?B?U1ZKbEJFSFFrYWN2aWdLcy9DdmtnRnJIKzJzZEcyb0FoRndJd0xuTjBO?=
 =?iso-2022-jp?B?Qi9Ic1E4dnV1V0N2RXhFZmk2VXgrbzMzRGZxakFvQVR5RlRMS1ZFOC9E?=
 =?iso-2022-jp?B?SkhvSFV2QVlPSFNwWTFLWWJvUnIva2t3WmlwTUlPYVgzeFV2VTRjOWY2?=
 =?iso-2022-jp?B?Z2w2YnRrTmdhdEdFQ0RYNS82Zm5UNW5INU5tdURvdEdKOGdlMEFwM2VB?=
 =?iso-2022-jp?B?TmNadEVjUDVXNVF6a0xBSFkzTTZzVHVRVHZiYU81MHF3Z2UwZjBlYWEz?=
 =?iso-2022-jp?B?elVUajJpbjhDK1d6dWJDL3UxK2ZqVlBDSGNDMVJFNFVQN3ZEd3lMdGd2?=
 =?iso-2022-jp?B?a1dyUEVRNmlyYkRNNDd6YVpqTDRHaFFndlB2WGx1bnBxcjNoMXpxUXFX?=
 =?iso-2022-jp?B?Y2p1ejVLSHczVWZ2cjNOUyt1NWNhNFBwQU80WHJpY1BpaEVIRWU1R25p?=
 =?iso-2022-jp?B?U0QrejdBaDA5UUkvN0Y4WGU0OElFaS9UUDNFekZjWURNZndNZ2tDMzFy?=
 =?iso-2022-jp?B?dlVRS3lObjZYOHVkdFFuRHRFUzlKdDZzMTZHQ3JCcVdzR0plclZPdkY2?=
 =?iso-2022-jp?B?K1MxSzcvaDU4S3F3OUJUODVqNGg3UjFjL0FtRDNrT2gxenQ1ZmFJU0xK?=
 =?iso-2022-jp?B?RnFJcldYNVJIVDdmcGRqZ0ZVZkVzYzIvWE80eFg2MjBMLzRBY1c0cHlj?=
 =?iso-2022-jp?B?M0NLRGpseEVCTmx5RGhlSGV0bUkxbFUxTDQyVWNydTRzcFlWeWZWcjFX?=
 =?iso-2022-jp?B?Vzh5SER2cHpRVWJMSXJIU2hsT3BHVW5JbUluRU81T2ttWSs5cnVEbGFS?=
 =?iso-2022-jp?B?NkxwNHRYTmo4a3VQY2cybGNmQ1E1eFgrbjh4M2ZTWGhaMHhUUzB0NTFl?=
 =?iso-2022-jp?B?aDN2MGh3L25keE9tUWZGdWhpei94L245dzQvbHFLenZXanl4NWtLZktP?=
 =?iso-2022-jp?B?SDlYVVJINlNKeDVIdldhNXFYTnpwL1Y4TEE3THlXemJKaXhVWUN1MDVF?=
 =?iso-2022-jp?B?VlVSU3RuWW9qaWZ3OXhkbG5VVGkyakxONVJPYkZFK2dGeU4vREtleXJm?=
 =?iso-2022-jp?B?Ym5LdWZDSDNmL0R4cE5lcEVrTnZNbW5YN2FuTEE3dGNZZlNRYmVXaVZG?=
 =?iso-2022-jp?B?MXZjOGV1M1VnNUdEUlRtV3hzWEVDR1h6ZjB1OGo0QWJVdUYreWxHMG8y?=
 =?iso-2022-jp?B?YnB0ODMycE9lbVo0NEdvdlM2TmozU3BWNDdxT1JDdDlqUEJqTzBXd29B?=
 =?iso-2022-jp?B?VjFSdG5COHNTV2JiUzZCWlRseHJZam5BeWFkc3dnQWdEYi9sUFFjMExa?=
 =?iso-2022-jp?B?SjZUaXR1Nm5TdHdGOHFhem1HZ1l1dXVTUFNEUzlUZlhHRTBCN3c0SDIy?=
 =?iso-2022-jp?B?eVpFZk80VjUzUTg1OGNqR09MdlRNYWZlU2t3a0k3ZC9BMkU3enYwd2hU?=
 =?iso-2022-jp?B?VkxMd0tOSEMrMUk5eTYvNEszdk1JKzZUbGtJV0VIMTNuMnEyWTMvaFQy?=
 =?iso-2022-jp?B?RnNTaFZvYlBqTklzUG1vZ0lscTk5S2ZkUkRRZUVOQlFjZysvNEhRSkFl?=
 =?iso-2022-jp?B?VDY5K0ZYbHJwM0lVUUNUM0hLNEpiU0RjcUxHTFVXczQ3TjRiSGNnVTlC?=
 =?iso-2022-jp?B?OFRHck9iVSs4ZjYvcUZFZ3ppbXcwRDFwRTJlNjFlVTZsRllmWkNrK2sx?=
 =?iso-2022-jp?B?RGpqT2t2dlZiS1lUc09uNnV3eWpkdm13WFQySFZyakp6blJsbTZXd3Bi?=
 =?iso-2022-jp?B?K1VHNjdheWVYVWsyMWxhVWcxZEVVdzRRcFN3bldtKytLSUpPQXJBWktK?=
 =?iso-2022-jp?B?MjdsVnV3bnozeHl0ZkxLN2tSZVJxdDIrdURYdGQzdHhCd2VOSG5SeFVG?=
 =?iso-2022-jp?B?TExSOHNZR2k2R0FMS1g4MHRqNWJOQkRYSng0L3VncmZoZythR0J1UEZT?=
 =?iso-2022-jp?B?R0psdGdKZi9hOC9SaTFwK1lxbkNtT2liRnUzTGR4bGYreDlnMFBUSjVh?=
 =?iso-2022-jp?B?MStZamdhQlBUZUVuV05zajNLYVkzdU9oWVE9PQ==?=
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYYPR01MB15132.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e2acf4e6-b162-45d5-be9e-08ddcf3f41ea
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Jul 2025 08:01:15.1720
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: xgE75Bw2vAPUPK8DsY4yIJjutj4+5HzXG7GUMbSlfSRSytwqw37b/bAc3FRCxZ1HHr5b8ZyNq7ithFF+pzmSz9o5mmahqKFNUruhpfKCbYg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYRPR01MB12237
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 30 Jul 2025 08:01:28 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/19619

Hello Shivanand,

> From: Shivanand.Kunijadar@toshiba-tsip.com <Shivanand.Kunijadar@toshiba-
> tsip.com>
> Sent: 29 July 2025 14:46
>=20
> Hello Chris,
>=20
>=20
>=20
> Hope you are doing well.
>=20
>=20
>=20
> *	I think the CIP core group just did something similar for a WFX
> service?
> *	You could go down the same route for zchunk. Either by using the
> same server or in setting up a new one.
>=20
>=20
>=20
> In CIP core/SWUpdate regular meetings, we are discussing alternate option=
s
> for hosting a file server for zchunk based updates.
>=20
> In case of new EC2 instance we should also consider the cost of the
> instance.
>=20
>=20
>=20
> So, Is there any possibility to use LAVA master server as a file server
> for zchunk updates? Is it also running in AWS?

Yes the LAVA master server is running in an AWS EC2 instance.

>=20
>=20
>=20
> Basically, we can configure either nginx or apache2  server in this PC an=
d
> use it for zchunk updates.

Yes this could work. I assume the CPU load is small.
Although any of CIP's EC2 instances could be used - it wouldn't save any do=
wnload times if it was the LAVA master because it's the LAVA labs that do t=
he downloading and they are spread worldwide.
You'd have to open a support ticket with LF IT to get it sorted as we (CIP)=
 don't have admin access.

>=20
> However, we need to check how to upload .zck file every time to LAVA
> master server pc before the running the tests and also LAVA jobs should
> access this file.

Assuming that GitLab CI is driving your testing, this would have to be done=
 here.
1) Upload .zck file to fileserver
2) Embed the relevant download URL in LAVA job template
3) Submit LAVA job

You'd have to implement a mechanism to support multiple different versions =
of the .zck files on a per-LAVA job basis so that the file you need to test=
 isn't overwritten by another.

Kind regards, Chris

>=20
>=20
>=20
> It is just an idea so I=1B$B!G=1B(Bm not sure whether it works. What do y=
ou think? Is
> it possible?
>=20
>=20
>=20
> Thanks & Regards
>=20
> Shivanand K
>=20
> From: Chris Paterson <Chris.Paterson2@renesas.com>
> Sent: 24 March 2025 15:46
> To: kunijadar shivanand(=1B$B#T#S#I#P=1B(B DITC_DIT-OST)
> <Shivanand.Kunijadar@toshiba-tsip.com>
> Cc: dinesh kumar(=1B$B#T#S#I#P=1B(B DITC_DIT-OST) <dinesh.kumar@toshiba-t=
sip.com>;
> hayashi kazuhiro(=1B$BNS=1B(B =1B$BOB9(=1B(B =1B$B#D#M#E=1B(B =1B$B!{#D#I=
#G""#M#P#S!{#M#P#4=1B(B)
> <kazuhiro3.hayashi@toshiba.co.jp>; jan.kiszka@siemens.com; balakumar
> adithya(=1B$B#T#S#I#P=1B(B DITC_DIT-OST) <Adithya.Balakumar@toshiba-tsip.=
com>;
> ashrith sai(=1B$B#T#S#I#P=1B(B DITC_DIT-OST) <Sai.Sathujoda@toshiba-tsip.=
com>; cip-
> dev@lists.cip-project.org
> Subject: RE: File server for zchunk swupdate update
>=20
>=20
>=20
> Hello Shivanand,
>=20
>=20
>=20
> I think the CIP core group just did something similar for a WFX service?
>=20
> You could go down the same route for zchunk. Either by using the same
> server or in setting up a new one.
>=20
>=20
>=20
> Either way the only people with admin access to install things are the LF
> admins.
>=20
> You can create a ticket with them through the LF helpdesk:
> https://jira.linuxfoundation.org/plugins/servlet/desk
>=20
>=20
>=20
> Kind regards, Chris
>=20
>=20
>=20
> From: Shivanand.Kunijadar@toshiba-tsip.com
> <mailto:Shivanand.Kunijadar@toshiba-tsip.com>
> <Shivanand.Kunijadar@toshiba-tsip.com <mailto:Shivanand.Kunijadar@toshiba=
-
> tsip.com> >
> Sent: 17 March 2025 13:57
> To: Chris Paterson <Chris.Paterson2@renesas.com
> <mailto:Chris.Paterson2@renesas.com> >
> Cc: dinesh.kumar@toshiba-tsip.com <mailto:dinesh.kumar@toshiba-tsip.com> =
;
> kazuhiro3.hayashi@toshiba.co.jp <mailto:kazuhiro3.hayashi@toshiba.co.jp> =
;
> jan.kiszka@siemens.com <mailto:jan.kiszka@siemens.com> ;
> Adithya.Balakumar@toshiba-tsip.com <mailto:Adithya.Balakumar@toshiba-
> tsip.com> ; Sai.Sathujoda@toshiba-tsip.com <mailto:Sai.Sathujoda@toshiba-
> tsip.com> ; cip-dev@lists.cip-project.org <mailto:cip-dev@lists.cip-
> project.org>
> Subject: File server for zchunk swupdate update
>=20
>=20
>=20
> Hi Chris,
>=20
>=20
>=20
> This is regarding the zchunk based swupdate verification on LAVA lab.
>=20
>=20
>=20
> The zchunk based update needs a file server where we keep .zck file and
> swupdate requests multiple byte ranges based on the requirement.
>=20
> In manual test scenario, this has been verified by keeping the file in
> Apache / nginx file server.
>=20
>=20
>=20
> In LAVA lab, I also verified zchunk update by installing Apache / nginx i=
n
> CIP image itself.
>=20
> In the last CIP core meeting, we discussed to use some container to host
> the file server (Apache or nginx) for this purpose instead of installing
> in the CIP image by considering the package size and maintenance.
>=20
>=20
>=20
> Do you know any EC2 instance where we can run docker container with
> nginx/Apache for this and should be accessible to LAVA lab?
>=20
> Or do you have any other ideas/place apart from EC2 instance for running
> container?
>=20
>=20
>=20
> Please provide your opinion.
>=20
>=20
>=20
> Thanks & Regards
>=20
> Shivanand K


