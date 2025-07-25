Return-Path: <nobuhiro1.iwamatsu@toshiba.co.jp>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA343C83F26
	for <webhook@archiver.kernel.org>; Fri, 25 Jul 2025 07:52:43 +0000 (UTC)
Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.135])
 by mx.groups.io with SMTP id smtpd.web11.14513.1753429953863477945
 for <cip-dev@lists.cip-project.org>;
 Fri, 25 Jul 2025 00:52:35 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=nobuhiro1.iwamatsu@toshiba.co.jp header.s=key1.smx header.b=B3L+UHVy;
 spf=pass (domain: toshiba.co.jp, ip: 210.130.202.135, mailfrom: nobuhiro1.iwamatsu@toshiba.co.jp)
DKIM-Signature: v=1;a=rsa-sha256;c=relaxed/simple;d=toshiba.co.jp;h=From:To:CC
	:Subject:Date:Message-ID:Content-Type:Content-Transfer-Encoding:MIME-Version;
	i=nobuhiro1.iwamatsu@toshiba.co.jp;s=key1.smx;t=1753429919;x=1754639519;bh=KL
	SPUG7Izy1SttX/11LFZ/54GrRofQPNJyeg6bcsYUU=;b=B3L+UHVym6+VEAjVVAlziROGACrM3Ayk
	XXX3YXahEchYdaUykA81z8S9UDRUIKny4DHmquaXUXns+SMEaNOCaySHtr0COy60HE+LSkqzSS+kh
	QaZ9UqsxygsvYCHkceyzBCtHhdrizQeQvI8np9a4KpDs9FTYpXykCRmb5e8haQSqJUsBht6A+gXDW
	GglQRM8X0Oh5NxKH1yqOkW5FT51DNoCC0jY8iDW8ByIvjrI9KhgZprON6hrUlXX2Jezgn3AZ2YTmz
	eIsN08t00i+/qev4nzM/k5V/vd4WqSuMzTlWg62dxbqpJHiDIxOct1nNHSnDj9KuQiBMqlxEQ7KJf
	HQ==;
Received: by mo-csw.securemx.jp (mx-mo-csw1801) id 56P7pwkO2019313; Fri, 25 Jul 2025 16:51:58 +0900
X-Iguazu-Qid: 2yAbuzQy5GwLTeq1Mh
X-Iguazu-QSIG: v=2; s=0; t=1753429918; q=2yAbuzQy5GwLTeq1Mh; m=6xhdFGjqSUL0mACGf2iV0qWtlyvWq+Zo0Gw4YFN93kY=
Received: from imx2-a.toshiba.co.jp (imx2-a.toshiba.co.jp [106.186.93.35])
	by relay.securemx.jp (mx-mr1800) id 56P7put71652133
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Fri, 25 Jul 2025 16:51:56 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tmpjc2qREQwHxfTBm50WeRhTWc7NXspwDLxMIntpkaSxzgipWbfZru5hGYE//GFXK14fAdIRQoBIzYi/JNWrWyIdxFFglM2+H1T8ennMF6kXNBs/fGek9swPz5cZg9EPXe5dj9V4ga5vpWnqa0AJjzP8tW4WBS7AeYw9KREeP7HRbuDVA5B/PtvKLe81u33svSiZic4O9uzhNj1cVKUCwBg/7AG6E3T/DwusGONhqmfnDJsof2p1TIzdnl4xuiDvRlzU/qbvSDULgcBEcNdRnOiB7PJxumcPe+SfegsenX0X9wpbh8LiVrWxllzAi8eR8pW0HU+QjDq6zb4Msp233A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=md5kTGovsgYwO88iL69i9YI/SajYI45jQJtl7LSA/Ws=;
 b=miM5eqZ+amvPKF2R9KOYTJeoaTAoYZv0rnw3Du8XTIKgGUbztJKqesgMoo+gVITihQ1fhOlt1fbN/2ea1PUq+cbkoTu8OuYXhzGEIBNhSRtSjJWfxGp9EOG8SLuE+EDkInvald40coNxUW7vRWdxgj62UxONztAE/n4+keCWxKXfJ6YVcBjCi0ebWJ9tSqfFb3VEysmhQR1qlH+9gyyqXk51a6dxOa09cXZUSOB/wsZgq51KpIdcNE7LQYhLHJWARsKl9JAsISc+F62rtm5vWfWPsHeKeIvKqbTbcZEBTP/9kRD9MhpcThJW6gFHb6G4w0GFxJvIm8UHib/+nI2Esg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=toshiba.co.jp; dmarc=pass action=none
 header.from=toshiba.co.jp; dkim=pass header.d=toshiba.co.jp; arc=none
From: <nobuhiro1.iwamatsu@toshiba.co.jp>
To: <cip-dev@lists.cip-project.org>
CC: <pavel@denx.de>, <jan.kiszka@siemens.com>,
        <masami.ichikawa@cybertrust.co.jp>, <chris.paterson2@renesas.com>,
        <uli@fpond.eu>
Subject: [ANNOUNCE] Release v6.12.39-cip5
Thread-Topic: [ANNOUNCE] Release v6.12.39-cip5
Thread-Index: Adv9OOUIneSRomR7QNKetwFs4KKbYQ==
Date: Fri, 25 Jul 2025 07:51:53 +0000
X-TSB-HOP2: ON
Message-ID: 
 <TY7PR01MB1481862E61D16EBED54186C899259A@TY7PR01MB14818.jpnprd01.prod.outlook.com>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=toshiba.co.jp;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TY7PR01MB14818:EE_|TY3PR01MB11322:EE_
x-ms-office365-filtering-correlation-id: 59d5daf5-113d-4f9d-b410-08ddcb501f21
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|366016|376014|38070700018;
x-microsoft-antispam-message-info: 
 =?iso-2022-jp?B?eER0NENKa2dsRmRSaUFLREEzbmJXelZPVFRjM2tlWk5meDN0T09SV2F2?=
 =?iso-2022-jp?B?ZkJLMXZST1JvTUtMdW5PYWVvTzF5TC9rcldPTko5ZFFWaDZoeTdIcmRC?=
 =?iso-2022-jp?B?MVlBL0UvQUZvOHdvRVhSbkhpdHorNjEzT0doZlQwYklrajYvS0l3ZnJq?=
 =?iso-2022-jp?B?WTRTMjNqRnpWaFFGYXhsYTgvcHFTUGwwTWNRY2N0YWdjeFlTZ3BJNGZ2?=
 =?iso-2022-jp?B?T3J1aGJZTFBKQy9pVUk4bGdKMEI4WHdrYVcxaGFWZnpHSGVOVHBGTkJh?=
 =?iso-2022-jp?B?M3lTNFFZWFRGS0doT1VGZ1IvbkxDMTc3YTJaU0hOVXdnQS9DREpNWmFH?=
 =?iso-2022-jp?B?MG90M2g2cnNGYWk0azhPb0RwalUvUURaYk1GVHBuNFFQa05GOHlPYkEz?=
 =?iso-2022-jp?B?YnoyVzB0TGZNM3VJdnBaRDFsaVArMDNDbXNscUVqVTNzZWxkQWR4V00r?=
 =?iso-2022-jp?B?U0Z1MXNoQzI2dFlzOFNPN3h1YVJSaC85OW55dnNLSVJHTUkrOERVVW9w?=
 =?iso-2022-jp?B?c00wR05vQVBVYkdjUkRCUDdUcmhlazYxM3UyVnFZbG9pekNpVm5nRVpT?=
 =?iso-2022-jp?B?QmFwUGxXZTJIYmNPamorbC9DbHIzNGl4MkVmd29Rb1hvOTlmRjJQbUlt?=
 =?iso-2022-jp?B?WmEwQmZEVk5jR0VPVDVzOGdjU1R0VUR5bTY0dW1BY0tzaC9VWjQ5Q1Ja?=
 =?iso-2022-jp?B?L1hhUjE3emEwdGcvaURmQkZudnpJb1I2WUJiREMwK3FXQllPZTFjVGZk?=
 =?iso-2022-jp?B?SDdoc0h0ak11U21oK3hEN2lXTXpuY05XWFVnRUh3cjk1VnlXcmsrYnlM?=
 =?iso-2022-jp?B?OXNkeTlFZVB5bVN4S1o1eUdENU1HT3Y4c3dFWG9QR2x1U09OdVlWVjJy?=
 =?iso-2022-jp?B?Z25ITCtTSUVBTjg2aHdDZHg4Tk9JV0tsWmZLV3M1eVNtSUV4TjBMZStm?=
 =?iso-2022-jp?B?ZTJqVWFqZ0JjbmJaZ3phVnIwTzYzOEdFZDdJcllORHFwKzNIZ2tPamN6?=
 =?iso-2022-jp?B?ZXVyTmFoZ2V2cUpVRjZMemJoYjlTeTZFU2NWZzhqb2FKRjFNL3dmZC81?=
 =?iso-2022-jp?B?bDJkSnJPQkpyeXhvQmxISkVtRm4rbzNYMUpFQUpPdUkrUmZQd0M2Mjdn?=
 =?iso-2022-jp?B?T3NhSWJQYTdraWxEQjVBZkJrL0FMOGVTb2J4dVRlakROZXVoTnlFN0xn?=
 =?iso-2022-jp?B?YlVLSkZlUXp6eEljQklYUktwSm16VUxlT3ZTMXUwTkw1b2pSOUtpM1Ft?=
 =?iso-2022-jp?B?ZkpuUjh6Q0s3bVAvRndKODliZHJsS3p3cFhuQlN1SG0vaEIwdCttMFd3?=
 =?iso-2022-jp?B?dlZCYWtGdmFnS1hjWGV0OGF5VmhDZkdXY3NJV05HOU1GYzNETHE0VThQ?=
 =?iso-2022-jp?B?VDhFbUNBeGEwcGtMVmt3dHRTQ1dvWGs2R2NXbm5Ed1QzZjZMTWZ2QXIw?=
 =?iso-2022-jp?B?TlBMYkdLbG1JaGJoSVMwc1FrcmRXUEdVQWtDQnJWekR3cytNZjBucU5X?=
 =?iso-2022-jp?B?aTRWbVdwbzE5RXg5YmN3QXREL3drOUYwNzllUE1vRE03OWpBeVAzMEdR?=
 =?iso-2022-jp?B?Vk01SGVCMWRjZk8rbnRJR1NvYkFLMnBRRE1zdUY2blVLbXd2Zi9EQTk1?=
 =?iso-2022-jp?B?c2VqWUlBenN2cXBaSWVCMDQ3VXhXZnNMRmpFMHRxZEc0enhxNzBWSDhX?=
 =?iso-2022-jp?B?WnI0NGpxQTl4STlveDJqSmQ1dWJXYkkrNFVqYzdzTG16VFJQbzFVdmhW?=
 =?iso-2022-jp?B?WEN6b3ZkeFpKQ1JTN1p6ZTZYaENwQTRIbVp5d1M4L1JVZVRlZW00VjFH?=
 =?iso-2022-jp?B?S1lvT2ViSVpoOUVna2hNQ21pNHlQUEdjUHcwRlNJYm54V3dLd3NWelJv?=
 =?iso-2022-jp?B?d2JZZzhXRldlZDBtOHMvdzVqUDJ6SUlzb2RnLzVpUk9IM0U5OHpqSGQ2?=
 =?iso-2022-jp?B?NjQ0N1ZPWWp4R2Q0NWVCd1c4NG1NcGQvb3FKblo5REtSQW9vMXpYQXFw?=
 =?iso-2022-jp?B?dkJUSTdSRW50ZTBadkYwLy83eThac2RTaGY5S0Q5OEl3M2tGL2Q4dHZC?=
 =?iso-2022-jp?B?TkxXczg2OXlQdENRZWh5WmZuY2ZLL1p5dGRRSGZNbnJObG02UjdlcjRN?=
 =?iso-2022-jp?B?NGNUNjFPTktFaDM4c0N6NUVkSUZTMjFjcEJtRlUwL2pSVDJWUW1ic3cx?=
 =?iso-2022-jp?B?Y1JrPQ==?=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:ja;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY7PR01MB14818.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?iso-2022-jp?B?TkovcnNWak16RjZ0cUI2MUJqbGxyd2lBRnR0V3U2UGdOZFRwV3pGQnBO?=
 =?iso-2022-jp?B?YllvUEQwMnFOdnVHQ3hpbDRJaXgxTXNMZ2h4L0pWZ3JERHorbzcyY01Q?=
 =?iso-2022-jp?B?dllVbkhaeUJ6R2RqM09kMjdVUVJXWlRBVHdsUVoxRHQ2MGFmSE1wQXlJ?=
 =?iso-2022-jp?B?anJNS0dDK0k2V0ZrM2ppY0ZFS0JCOHRGZ21sNThIbDc5SktVaFFEK0VJ?=
 =?iso-2022-jp?B?ZlBWcTd4VHhTbnROL3RienduMzRpTGlLaFZSV2dKa2plLzhQeEVpTi9J?=
 =?iso-2022-jp?B?S2R3Y0lUREd0MnAxWWcrZ3diN1lIRW5HUDBZWU1pZ2ZVNjQxSS9aa1Bk?=
 =?iso-2022-jp?B?M3hRQWtsRENranVvdnpENTkvdHRpdjNnSmxYK2xNV2Y0U2VRdUdBNUFz?=
 =?iso-2022-jp?B?MUM0UnJsQjF5WWJWelpKd2M3dW0vOU1LcHB1VmpRWHJ4MUJkZ0NUM1Rp?=
 =?iso-2022-jp?B?OU1JM2tCRTlwbmk5Mjh1UVhSRFZZc3lxZ09aMi9LY0p2VGdZQytFeEwx?=
 =?iso-2022-jp?B?NDhTUEZ3VEdHUDhySGxObndxTFpvT3RrK1pmMU5WZUZFOVNmMktMMDF2?=
 =?iso-2022-jp?B?RjlDUnc5NmFQNXorTmRtVjdJNm8xcmpzQjhsN3FZV0kyV3ZrTGFxanJK?=
 =?iso-2022-jp?B?RWtlVFZkeDBabDVTcFNQRDg3YkVSd2J0L0pZcWJta2JYSTJFc25hMzFK?=
 =?iso-2022-jp?B?eGlvbUFweE5NcURSd0dpMStocWFGeStjS2hpVGFlSmZteUVBUVJLbzBt?=
 =?iso-2022-jp?B?cWRKNldWSkpKSytQSzB1aEVYd3hxekRZc3pxcGxCbUhIYmVIaWplZklM?=
 =?iso-2022-jp?B?aW9Lc3Z3dSs4eVJRMzFkLzZENUsrcno2eDdqV1N6b05UanYyNHBVdWRm?=
 =?iso-2022-jp?B?MGwrc3VYT242YkhtSnNJZFh3QTFYYVpYNVNoRlNab2dYUS9yOERFZlk2?=
 =?iso-2022-jp?B?dzNzb1g1cis2MDZMbUx0b0l1dXZLdjFHWG9CNE15ZmlqaUIySjdpc1lp?=
 =?iso-2022-jp?B?VFZ4QUNlWWdmYmR6aStmd3Y2cENrK0JIZzI3d1ptdzA3cTBjc1UwampC?=
 =?iso-2022-jp?B?WEZvdVZDd3h1N1RTZXYrQndORFMwU3BlbS9RSDROc3ZLaWQyallqQjBa?=
 =?iso-2022-jp?B?dHMyM2tVOUhaWDVKK2VqTWtNdFczL2ZoSThkdDJnK0t3d2NrS0dYUWUv?=
 =?iso-2022-jp?B?WTB0Y1BOUkFjRDBRbHZsWVVZT2ErbEVucDRPcWlXbzNtY2RvZ0FEanBy?=
 =?iso-2022-jp?B?dDdmK2N1a3lrOUh3ZlVMelVlV2lKN0NNOS83eVkyNHdpNUxrT1dkdEVJ?=
 =?iso-2022-jp?B?eTd3U2U5dE42elVKeE9aWUFzVFh6azR5a1ZoZ3dGZDFhVjgrZ2lqOWxP?=
 =?iso-2022-jp?B?VEZvVmNFc1p5MFZjNnRGNUlLVFA3cFJKMWgwQjdXcVIvb0p2UlNqMzht?=
 =?iso-2022-jp?B?aW91clhnb2FyMDFDQ2hYTGxyOFpLdEY5UVdJMjVYdzlsNGZ0bTZmOUpr?=
 =?iso-2022-jp?B?TVFNaGNHYm9sUXNobnc0QnRFalgvN2J2YW5DbzR2cXoyVkFKUUFtZ3dh?=
 =?iso-2022-jp?B?NnRaNXRLcTgwblNnZklvN0pNK2g1OElaUG1JRHNVdEgvVTZtbWZQeUZs?=
 =?iso-2022-jp?B?MEhvbmNQN2JVaVoxUE9ORzBFSkN2Wk5qRUFBdTRTRi91NTZvYVBzZ1RJ?=
 =?iso-2022-jp?B?UkZWUVU2MlJGM2pINzJPeGdHYk9sUkxrSHhEVkVJL3R2TlJzc0xVVHl4?=
 =?iso-2022-jp?B?a2lxUk5oNC9tbXgvb01LVWxWN0lQUCtQTEtHcUs4bVRlM0F5TGhnbG1O?=
 =?iso-2022-jp?B?ei9kcW5SNTN0cUQ5M3V0dG1XNWtRbmcrUFJSd1VoR25Bbk51V0oyL0tG?=
 =?iso-2022-jp?B?RUR5aGsvVEZDdktlZldVOHBsak5wVzBWNkRnWWJPbmc3ckdjOEt5U243?=
 =?iso-2022-jp?B?OFdHUm81NGVYdTd4UHF6am1oVUFGVHBMeUJVMHRRRFp6Nno1L0gwejRQ?=
 =?iso-2022-jp?B?N3Y0ZGxDU2FmU0QwOG1iMkNCK2puL3paVmlrUG5TYXR5cVhUTWxxVHFp?=
 =?iso-2022-jp?B?WkV6cGYrMTBudm9xK0t6MFhVNU5BZndqend4Uk1CYWFWbWJpMkI1bThq?=
 =?iso-2022-jp?B?d1UrR253NmZCcW5QcDJlUzkwRnhWNVVCWURUTzRSemoxTlVETVJEaFpY?=
 =?iso-2022-jp?B?ZjVTRkU3ZVkrSE1CaC8xVENlVHhnVXEyakhUUmlzOURwU3V0ZTdOTmdm?=
 =?iso-2022-jp?B?NWI1b0pIcm92YlVRQkd2RWFIREVGbGlsdjZWeTNOYksrOEdJcXpib21H?=
 =?iso-2022-jp?B?WUFENE1aZ0xFTnpBN05hTEpoamVIaXU1bXc9PQ==?=
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: toshiba.co.jp
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY7PR01MB14818.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 59d5daf5-113d-4f9d-b410-08ddcb501f21
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Jul 2025 07:51:53.6194
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f109924e-fb71-4ba0-b2cc-65dcdf6fbe4f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: lur154VlvHPL1arcZgkkMc47V5z/CLKnMYqKJLm2jYYCCv0NfJwWqj95RZyNpT/0WpRXeEKwzHpfLHUC+Hk3+WC5E6lUhwan0//wuxQSxqf+RhTQ957xxOIM2UKOtv1w
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY3PR01MB11322
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 25 Jul 2025 07:52:43 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/19591

Hi all,

CIP kernel team has released Linux kernel v6.12.39-cip5.
The linux-6.12.y-cip tree has been updated base version from v6.12.36 to v6=
.12.39.
This version applied Display Unit, clock and CANFD updates for Renesas ARM6=
4 SoC.

Information about this release is as follows:

  v6.12.39-cip5:
    repository:
      https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.git
    branch:
      linux-6.12.y-cip
    commit hash:
      c5c2a910062275d412bd98e33e4e25c3ea2b21b4
    fixed CVEs:
      CVE-2025-38350: net/sched: Always pass notifications when child class=
 becomes empty
      CVE-2025-38243: btrfs: fix invalid inode pointer dereferences during =
log replay
      CVE-2025-38279: bpf: Do not include stack ptr register in precision b=
acktracking bookkeeping
      CVE-2024-36357: TSA-L1 (TSA in the L1 data cache)
      CVE-2025-38289: scsi: lpfc: Avoid potential ndlp use-after-free in de=
v_loss_tmo_callbk
      CVE-2025-38139: netfs: Fix oops in write-retry from mis-resetting the=
 subreq iterator
      CVE-2024-36350: TSA-SQ (TSA in the Store Queues)
      CVE-2025-38242: mm: userfaultfd: fix race of userfaultfd_move and swa=
p cache
      CVE-2025-38104: drm/amdgpu: Replace Mutex with Spinlock for RLCG regi=
ster access to avoid Priority Inversion in SRIOV
      CVE-2025-37984: crypto: ecdsa - Harden against integer overflows in D=
IV_ROUND_UP()
      CVE-2025-38067: rseq: Fix segfault on registration when rseq_cs is no=
n-zero
      CVE-2025-27558: IEEE P802.11-REVme D1.1 through D7.0 allows FragAttac=
ks against mesh ...
      CVE-2025-38349: eventpoll: don't decrement ep refcount while still ho=
lding the ep mutex
    added commits:
      CIP: Bump version suffix to -cip5 after merge from stable
      arm64: dts: renesas: r9a09g047e57-smarc: Enable CAN Transceiver
      arm64: dts: renesas: r9a09g047e57-smarc: Enable CANFD
      arm64: dts: renesas: r9a09g047: Add CANFD node
      can: rcar_canfd: Add RZ/G3E support
      can: rcar_canfd: Enhance multi_channel_irqs handling
      can: rcar_canfd: Add external_clk variable to struct rcar_canfd_hw_in=
fo
      can: rcar_canfd: Add sh variable to struct rcar_canfd_hw_info
      can: rcar_canfd: Add struct rcanfd_regs variable to struct rcar_canfd=
_hw_info
      can: rcar_canfd: Add shared_can_regs variable to struct rcar_canfd_hw=
_info
      can: rcar_canfd: Add ch_interface_mode variable to struct rcar_canfd_=
hw_info
      can: rcar_canfd: Add {nom,data}_bittiming variables to struct rcar_ca=
nfd_hw_info
      can: rcar_canfd: Add max_cftml variable to struct rcar_canfd_hw_info
      can: rcar_canfd: Add max_aflpn variable to struct rcar_canfd_hw_info
      can: rcar_canfd: Add rnc_field_width variable to struct rcar_canfd_hw=
_info
      can: rcar_canfd: Update RCANFD_GAFLCFG macro
      can: rcar_canfd: Add rcar_canfd_setrnc()
      can: rcar_canfd: Drop the mask operation in RCANFD_GAFLCFG_SETRNC mac=
ro
      can: rcar_canfd: Update RCANFD_GERFL_ERR macro
      can: rcar_canfd: Drop RCANFD_GAFLCFG_GETRNC macro
      can: rcar_canfd: Use of_get_available_child_by_name()
      dt-bindings: can: renesas,rcar-canfd: Document RZ/G3E support
      dt-bindings: can: renesas,rcar-canfd: Simplify the conditional schema
      clk: renesas: rzv2h: Use both CLK_ON and CLK_MON bits for clock state=
 validation
      clk: renesas: rzv2h: Use str_on_off() helper in rzv2h_mod_clock_endis=
able()
      clk: renesas: rzv2h: Support static dividers without RMW
      clk: renesas: rzv2h: Add macro for defining static dividers
      clk: renesas: rzv2h: Add support for static mux clocks
      clk: renesas: rzv2h: Fix a typo
      clk: renesas: rzv2h: Sort compatible list based on SoC part number
      clk: renesas: rzv2h: Simplify rzv2h_cpg_assert()/rzv2h_cpg_deassert()
      clk: renesas: rzv2h: Improve rzv2h_ddiv_set_rate()
      clk: renesas: rzv2h: Rename PLL field macros for consistency
      clk: renesas: rzv2h: Add support for enabling PLLs
      clk: renesas: rzv2h: Remove unused `type` field from `struct pll_clk`
      clk: renesas: rzv2h: Update error message
      clk: renesas: rzv2h: Adjust for CPG_BUS_m_MSTOP starting from m =3D 1
      drm: renesas: rz-du: rzg2l_mipi_dsi: Update the comment in rzg2l_mipi=
_dsi_start_video()
      drm: renesas: Add zpos, alpha and blend properties to RZ/G2L DU
      drm: renesas: Extend RZ/G2L supported KMS formats
      drm: renesas: rz-du: Drop bpp variable from struct rzg2l_du_format_in=
fo
      drm: renesas: rz-du: Support dmabuf import
      drm: renesas: rz-du: Add Kconfig dependency between RZG2L_DU and RZG2=
L_MIPI_DSI
      drm: renesas: rz-du: rzg2l_du_encoder: Fix max dot clock for DPI
      drm: renesas: rz-du: Drop DU_MCR0_DPI_OE macro

Best regards,
  Nobuhiro


