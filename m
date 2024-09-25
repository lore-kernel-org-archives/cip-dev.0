Return-Path: <sai.sathujoda@toshiba-tsip.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49170CF9C79
	for <webhook@archiver.kernel.org>; Wed, 25 Sep 2024 14:38:58 +0000 (UTC)
Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.152])
 by mx.groups.io with SMTP id smtpd.web11.17807.1727275136789394243
 for <cip-dev@lists.cip-project.org>;
 Wed, 25 Sep 2024 07:38:57 -0700
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: toshiba-tsip.com, ip: 210.130.202.152, mailfrom: sai.sathujoda@toshiba-tsip.com)
Received: by mo-csw.securemx.jp (mx-mo-csw1802) id 48PEcsdR1159376; Wed, 25 Sep 2024 23:38:55 +0900
X-Iguazu-Qid: 2yAb2N10Zdmee0IXKq
X-Iguazu-QSIG: v=2; s=0; t=1727275134; q=2yAb2N10Zdmee0IXKq; m=H0yur4yDhn1ipWeoyQrGPebDu/EYfBNQfzQfiPgWoI0=
Received: from imx2-a.toshiba.co.jp (imx2-a.toshiba.co.jp [106.186.93.35])
	by relay.securemx.jp (mx-mr1800) id 48PEcrHU1793855
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Wed, 25 Sep 2024 23:38:53 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AWJFgIrcnJrsefdK2NTZz0Q1qgbVWcF5h3eIqoL9EagbnX1ZnLB5cRMtkBl/nu3uyfbCfPABeosHryI1bMOuBCDL7qcFOKkrufyxJkmdgL2P5kWvgO2XqZOeEv1Tmw8A2S56C5S3J8MMrK8ymRt4wkigzofuSBaIB/Td8A5ZkQm43xndYUXm4JUygtp0WphuVVyTjx8d71HM61EoYhnPtycIrK95E/EPnRmqkqXYS8Qg3pOtLDbUPDAkF9+64CcLTYlr6pflpidZs0kwPfqqaeW1S7usW3hmKVsgLs0d9eXlY8L54X8nw1Div4QVldUlMAcI4qhQBwKoacwXwqxI4g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CvlfRrLvN2f8wcqrLIvCaO5T+iM16Lo9MjaxoFQgE1o=;
 b=hwNutZA+N6qeYTRDbR7N2GolIUU2zSij3rZOSFDXm1M8pFUZF+e50p3mPpCHvR7FbDDlb+rmAFU0j+YYgR0RcfaiscGtZ+/BuUdcXTi+8qR5Uo3LnAvxCsd3oTN2EVJv/VabrjgYYlQOFpffRTMH5b5X1d+NzcjqVnau1tu5P4PSv1C5aZVBNtHMG/eiD75W4ZJTHIHm8ZtM5Q55mgcJxeC0EyECInraObT27eCzSR+Q11bgCY3uMJjutASwJxKNg1eEJxmN5qjW8eWtfr21wJUh8VG1wVA9mL5WYv9IZYGOTwXzEnnm9Gvi0u1EpM4WywIzbcKkRmjRqnGRv+AOWA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=toshiba-tsip.com; dmarc=pass action=none
 header.from=toshiba-tsip.com; dkim=pass header.d=toshiba-tsip.com; arc=none
From: <Sai.Sathujoda@toshiba-tsip.com>
To: <Chris.Paterson2@renesas.com>, <michael.adler@siemens.com>
CC: <kazuhiro3.hayashi@toshiba.co.jp>, <dinesh.kumar@toshiba-tsip.com>,
        <cip-dev@lists.cip-project.org>
Subject: Re: [cip-dev] Issue with 'small' Gitlab runners
Thread-Topic: [cip-dev] Issue with 'small' Gitlab runners
Thread-Index: 
 Adr6EQ3RL8rQAtQSSy+tF4/i30H+FAACvaEwAB6AvfAAoAnrAABqrZEQBBtW1XAAAKEVoQAAz0WwAAivPPc=
Date: Wed, 25 Sep 2024 14:38:50 +0000
X-TSB-HOP2: ON
Message-ID: 
 <OS3PR01MB61038FEE197308A2E5B51F56C2692@OS3PR01MB6103.jpnprd01.prod.outlook.com>
References: 
 <OS3PR01MB6103DA72FFDEBC407A5900A6C2962@OS3PR01MB6103.jpnprd01.prod.outlook.com>
 <TYYPR01MB12402CF459412685A6824CB45B7962@TYYPR01MB12402.jpnprd01.prod.outlook.com>
 <OS3PR01MB610349E8EFC2F9E8ECEBD450C2972@OS3PR01MB6103.jpnprd01.prod.outlook.com>
 <cnkp47rzuahu7yls5ch2mi6okr6w3uevw6eqehmc3ti3f6zesu@of6ittbitant>
 <OS3PR01MB61035250A83977730E393D70C29C2@OS3PR01MB6103.jpnprd01.prod.outlook.com>
 <OS9PR01MB12389D4A1AC2973E4C3AF27FDB7692@OS9PR01MB12389.jpnprd01.prod.outlook.com>
 <OS3PR01MB610365D7958F2829214B6BF1C2692@OS3PR01MB6103.jpnprd01.prod.outlook.com>
 <OS9PR01MB12389DB1E8371D5A1747C9094B7692@OS9PR01MB12389.jpnprd01.prod.outlook.com>
In-Reply-To: 
 <OS9PR01MB12389DB1E8371D5A1747C9094B7692@OS9PR01MB12389.jpnprd01.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=toshiba-tsip.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OS3PR01MB6103:EE_|TY3PR01MB11412:EE_
x-ms-office365-filtering-correlation-id: b81f08de-3655-496e-fd62-08dcdd6fc5bf
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|376014|366016|38070700018;
x-microsoft-antispam-message-info: 
 =?iso-2022-jp?B?ZWRPSnQzRUFxQWJ6U3hyMFhaYWFkV3Ftc2xmVDFVMGYzTkhoRU5rWVNO?=
 =?iso-2022-jp?B?RUowaTU2RUtKR0dSWVBvc05aWmo0NWpUQ1k2dlBSb1FJRlJWOE9MOEd0?=
 =?iso-2022-jp?B?bzZ3OVBwWDA4YWVBamhWU3M0V0xNM2VhV3NJcHlBWEVBejZwRWJyaGxU?=
 =?iso-2022-jp?B?bEtPb2p5dG5FTjhkRVV2cG5lWDRTVHBrbkwyNTBoWTlnNG9CeUE4c24v?=
 =?iso-2022-jp?B?dmlqN05jcUhWZXBQNE8zeGRTdGQ0MHdpYzhsQS9HcEE4UVpnRkNFdXhQ?=
 =?iso-2022-jp?B?MGdzSm8rNDlEVzNpKzh2d1NySnc3dHplNHltUVJnb1FEVUVZWHNYR0Ra?=
 =?iso-2022-jp?B?d0JVQlF0RTRhWWF3bG1RUHJ5bmhTMERtL2l5QlVxbzFuOUlVbEVYcDVx?=
 =?iso-2022-jp?B?VnREQSswMVd0T0tPdjI4ck8zYm15Y2VOS3Q0MWlacVVSN2M3K1dONlha?=
 =?iso-2022-jp?B?RmJNM2ZpNU5NcFB5QkxYWlBrU29TZDcwRUl6bXZwOXUyNVZjNnNXcjFp?=
 =?iso-2022-jp?B?TU1rSTg1QnlpckJ5UEtXWDlnUTJWdTc2eTAvSTIrdy9tU3BEN0d1ZTN4?=
 =?iso-2022-jp?B?UkQrMnVyeXRacHJpN2JGS1UxbFBmbGMxbFd0QXU1UmNoYnNNekhDVVNR?=
 =?iso-2022-jp?B?UVFsV2Z1a25NZHZjaUF2TG41dWJmdzVmMnNEd2lYZjVzRGZLY0ZiODRB?=
 =?iso-2022-jp?B?RWdtMmJ4cDlrM3E1aWpWVmk5L2hiWTBJTE1KZGVuSHE1YU1BeEp6L2Fx?=
 =?iso-2022-jp?B?UGJNKzFoWHBhWmlDbzNCbTU5TnJwY0lRbjEzZXpnMStzTk0yU0dBamg5?=
 =?iso-2022-jp?B?RnhEVllHVU1UT2ZudWJDM0VHWUpRYU5CMktTOXRqYkVWajJObU5kWXJj?=
 =?iso-2022-jp?B?T1I3NUNHd2NCYldqd3kyOHJqU3NnSnh1RDZLR0FRNHNqSFo0dC90TmNa?=
 =?iso-2022-jp?B?Q1QyTnJhRkNzVlJ0QitUTktsMTZWaXljM085ZEZuWkgwZ0paeFdjb2Y5?=
 =?iso-2022-jp?B?eDdIZ3FFaVg3TExlVFBuY3JZL0EzMG5mY1QvUjltUGVFaEFJazNWaWxP?=
 =?iso-2022-jp?B?eW1lWkcwcnpLWVNRQ2EwZDd4cDNjYVVXcDVnakI2YzJ3S1VPbUVtUHRv?=
 =?iso-2022-jp?B?b0tEYWttdEU2cFJ5TmE0Mmp1cTJEQzR4ZERueHFJREdWbU1Jd1pNaWtZ?=
 =?iso-2022-jp?B?dDQwZ0grTW1JUFJsSlFQOE1hSFBPcGk1VTlBMWx6V0tMM0JkOXZtWllk?=
 =?iso-2022-jp?B?b0JqL1hHM3hRem43a0FIYmtFbEVuM2R0eGZEdXlvaHFxdVVVbEk1R3hy?=
 =?iso-2022-jp?B?QkJMaWNDdWpPTE13Rzludm9IUkYwMVlxM09qVGlXRTh2eHU2WEVZREZJ?=
 =?iso-2022-jp?B?aEtsU3pQVDJ3aktjdnM1azd0R0FqcXgvVkZjS2ZxamV4SlZNRVdZamk3?=
 =?iso-2022-jp?B?M2FIeHN6emEvWTJYMTVEUkJsWFdUOEEzbjdENjBnUzdIcVY5QndaZHdS?=
 =?iso-2022-jp?B?NzJxci9sZWFIZWY3cTlac0U5VnhXam5rSHV2dVdxUmRua2RCdkRzMnp5?=
 =?iso-2022-jp?B?Vkd4RlNVTFUzNnJOTmlLWXhCQkRxVE1YWHFaOWlRTlhZVmovN1pnN3Jx?=
 =?iso-2022-jp?B?eTFSWFo3Zm1KeisyTnlIa3ZybG1rZWtyNTBaVnN5NUJqeitSeHpzMTl3?=
 =?iso-2022-jp?B?UFdWMVVtck8zb3BUMHo4RFpiYXRSUHJzSHhpZm5IbWtldWNBT29XN0Fs?=
 =?iso-2022-jp?B?aWgyVjZ3S3BMM2tESzBHQ0t1dm1RUlFyb1NEbUo2UTVyekpnOCtKNWZm?=
 =?iso-2022-jp?B?LzR5VHRWcXZWbVVlVVU2aTR4YjBpZXFzNDF5L3BpaGg2d1g0QVAwblpQ?=
 =?iso-2022-jp?B?cGx3bm9mVWp1Yzl3UTJVbzVrTDRCU3huYmQvTW1vV1A3aXNpNVhoWmND?=
 =?iso-2022-jp?B?dUxHRlBwYVlmZzNGMmtVdkYyVUI4bkxvdmxWYWx5U1dKczJVMkVrZnR3?=
 =?iso-2022-jp?B?QT0=?=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:ja;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS3PR01MB6103.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?iso-2022-jp?B?NEVST2JvdXdTVzNUZFh5UERFTUtGZVpuZlJiaVU0VTA2K1kvbzlDOEI5?=
 =?iso-2022-jp?B?RkdmREd3RmVoak0wRFRuSkh0eGt1M1ZvK0d3M2tTQXNQTDQvOVYxb09u?=
 =?iso-2022-jp?B?UjBabHVhUXQrcXVsNm9mWTU0ZG9WTmlUYTk1dE1OT250NTZPczBiZ0lF?=
 =?iso-2022-jp?B?dWxKbTJTWnUyZEtGTm1BeFVnUmJoWjdObkxOTlpxZXNUTlFaZ3NaWDND?=
 =?iso-2022-jp?B?RFVmY1hoS0QwNUFZNFA0WHNoamY4NUNON0tFSlJiU2ZObXhaU3d2SHdK?=
 =?iso-2022-jp?B?b1BRRWd0eGJCWkdGbmVXbFNYQXIvTU1tbFFlemRCOXVOVTgxaEhLSzAv?=
 =?iso-2022-jp?B?UDAvbGIzQ1E2L1VOZVdCM3hOTlczYmsraGJDRHVSb0FEdlg0eGNYUTE3?=
 =?iso-2022-jp?B?cy94WXpHa0xqR1hncDhXM0xJYVowbHNRWEdPTXNSUTRaMURTcjdpbE9h?=
 =?iso-2022-jp?B?cUM1bi9CV2hrVFYwYTJQa1VFVVk5a3ZxSmNyT25HTlZJd00vUVp6Y1cz?=
 =?iso-2022-jp?B?enNpOXQyc3JiNnhlTlNRZm9vWE9Md082bllQbmhmT1B5d3ZyY1IwVTY5?=
 =?iso-2022-jp?B?T1Q1NU1aaFdMbXlLV2hIbFQyMmhlRXBuVUFwakMvRnZNaFR2bnZSS3Nl?=
 =?iso-2022-jp?B?Y2M2U2QvbGsxUCs0bi9ESzNrL2VXTlZ0RUFZZHZmNTlrSHFscVJLdzVU?=
 =?iso-2022-jp?B?d3JxbHJRSDlaRlJ0MWpnNGFNRmVkd2kzWGlCbDM3WHZlelBSZXN5MkM0?=
 =?iso-2022-jp?B?Vm1yV3VWUnRUQk1DQ0VhV0UxV3NxSENoUFppVXZkK0JNMW90THRLd3I5?=
 =?iso-2022-jp?B?eHNxUFBTTEhxMWxnbVc3N0oyVWFsL3pieHJSTVduaEN0ZlZybkFNRVRF?=
 =?iso-2022-jp?B?UkZIMm9JeEptK244NE5yRzJRYlZrUmhrQ244ai9aSkJlV09CcWZ6bnBk?=
 =?iso-2022-jp?B?b3p2anhPdHUxQUtCaVdNVEFLTWlYUnpkL0YxZEtqMnIrSzJyR05BMHo5?=
 =?iso-2022-jp?B?T3VkYmIwQmFOTVBxb0ZDcytyZHkxYVlYTU55S0pmaGdGRU1zbm9iRFVz?=
 =?iso-2022-jp?B?SVp5bzV4bmtIM2FWVzAyYTZDTlRRd09WTmlhbWE2Nk1TUnRkdXY1U0tL?=
 =?iso-2022-jp?B?WnRFVEhESk1XSlpsaytRbWc0M0lyTlFsNGMreDlIM0xQNlVPTmZjZFA3?=
 =?iso-2022-jp?B?RjdvTUZMak9VVlpTRDBIOUpObUlITWNwcEtLNFlwNm9xRGJsMzNMUkZO?=
 =?iso-2022-jp?B?N2ZvOW55TTc2QkVHd3N1dXpPZ1I3VkIxTU5yQnlHSTFQRisrUThjNTND?=
 =?iso-2022-jp?B?bkV5RFFFUERZc0Y0MlRTY1NVMkhtb2J1NElTUExGaWJ2SC9NenpMSnNo?=
 =?iso-2022-jp?B?RjhlZmVNY1luU3NFSkJENGxsekYzaGpoSGJvV0o0V0NhdGQvZ1pDdXRK?=
 =?iso-2022-jp?B?WXlpRmtIakV2VkxlSUltRWI1aXFaR1hnOWpJM25CcWFrNStQRzlJbTZk?=
 =?iso-2022-jp?B?dG95Ump4YXREUFlobHYvZEZydmdUMnZiRzg3dEZjZ0lnRGQ4SWRjTXh5?=
 =?iso-2022-jp?B?Wkp2ZUVWY0dvYjc0WHk3RGxNQkFxWkh3VVFjTkVGQWczYmU0UVFqTlRj?=
 =?iso-2022-jp?B?RVJ4QXFJSUFoT24zT2xpKy9DSlQ3Yjk4VXdiUytTeG9FZmhDNkhiVmt4?=
 =?iso-2022-jp?B?bm5hc0M0ek84SHArUFIvVjljV0pSWVlHSjFBSkdmZjRaMFI0b2pzTzV6?=
 =?iso-2022-jp?B?MEx5S1poNjNKNzg3WFQ2K1p5Wit6WHBweVlhaEhiSWR2N1o3T0JJOGNj?=
 =?iso-2022-jp?B?SWlNWXpTV2JQOEQvSFZMekpiNGtrSVVTRWNrdkRnQTNoc2ZSd0x2QUpn?=
 =?iso-2022-jp?B?RjY2RnU5cUFDdUNidzkxZSs2a2VycEVuQmhlRHRvcUZGN29LZ0EzZGdo?=
 =?iso-2022-jp?B?dTN1WExxVWV0UEcvTFZQMmh3RUdWK2t1RkFKczJ0WkE4NkY5b3NVRktR?=
 =?iso-2022-jp?B?VDBBQ0NFajlBQXBiZmhDNUVzU1pLQmxtZEJHOTFqWTZvWTJXUThRN2lM?=
 =?iso-2022-jp?B?T0lOUTdrTHlMNVJNZmVDYmpqREJodDBxRlhnOWVxSXRkam5zeDRrNW96?=
 =?iso-2022-jp?B?OG43azBhTjAvUlVud3EvSmlmYU5EeldLRUJNZkdoQm9JSUc5dE4vWTR2?=
 =?iso-2022-jp?B?bzZVRCt1OXFXNUwwOG9kZWwwTXliL1FoeE0yajdQeEFBUkEzUTlpUzBV?=
 =?iso-2022-jp?B?bi9aTm9xdEc2Ung1SUo4UmZ2NDFuUHlJYlJxVGtqTWVXK3hXdXJhQXBm?=
 =?iso-2022-jp?B?cE44elNJSXJ2Sk5adEI5UndjdjNDTDE1ZHc9PQ==?=
Content-Type: multipart/alternative;
	boundary="_000_OS3PR01MB61038FEE197308A2E5B51F56C2692OS3PR01MB6103jpnp_"
MIME-Version: 1.0
X-OriginatorOrg: toshiba-tsip.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OS3PR01MB6103.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b81f08de-3655-496e-fd62-08dcdd6fc5bf
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Sep 2024 14:38:50.8451
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f109924e-fb71-4ba0-b2cc-65dcdf6fbe4f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 1MIrXQHc1SN6otxQ/ZDgn38W30oPTzIcGfnfMIJYGyY6FszVhb00pXVjVJXvFw67YIKXAcs+9t/cCVHjWJiNk8NGdg9IEuCfVP7QMpea5s8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY3PR01MB11412
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 25 Sep 2024 14:38:58 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/16919

--_000_OS3PR01MB61038FEE197308A2E5B51F56C2692OS3PR01MB6103jpnp_
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable

Hello Chris,

I apologize for an incomplete reply to your question.

I went through your debug pipelines in isar-cip-core. I observed hihope-rzg=
2m-buster.dpkg_status taking around 9 minutes to generate a cve report  in =
CI while bullseye and bookworm targets' cve reports are generated in around=
 1-2 minutes. Based on my understanding it is taking a lot of time to gener=
ate cve-reports from buster targets in CI.

Answering your question, I locally executed cve report generator script in =
my Debian machine (8 cores, Intel(R) Core(TM) i7-9700 CPU @ 3.00GHz) inside=
 a Docker container.

I have no name!@c3cf62622aab:/work$ date
Wed Sep 25 14:22:23 UTC 2024
I have no name!@c3cf62622aab:/work$ ./cve_checker.py --suite buster --statu=
s cip-core-image-cip-core-buster-hihope-rzg2m.dpkg_status
I have no name!@c3cf62622aab:/work$ date
Wed Sep 25 14:23:48 UTC 2024

The duration is approximately around 90 seconds.

Regards,
Sai Ashrith Sathujoda
________________________________
From: Chris Paterson <Chris.Paterson2@renesas.com>
Sent: Wednesday, September 25, 2024 5:13 PM
To: ashrith sai(=1B$B#T#S#I#P=1B(B) <Sai.Sathujoda@toshiba-tsip.com>; micha=
el.adler@siemens.com <michael.adler@siemens.com>
Cc: hayashi kazuhiro(=1B$BNS=1B(B =1B$BOB9(=1B(B =1B$B#D#M#E=1B(B =1B$B!{#D=
#I#G""#M#P#S!{#M#P#4=1B(B) <kazuhiro3.hayashi@toshiba.co.jp>; dinesh kumar(=
=1B$B#T#S#I#P=1B(B TMIEC ODG Porting) <dinesh.kumar@toshiba-tsip.com>; cip-=
dev@lists.cip-project.org <cip-dev@lists.cip-project.org>
Subject: RE: [cip-dev] Issue with 'small' Gitlab runners


Hello Sai,



Do you know how long the cve checks normally take?

I=1B$B!G=1B(Bve set up my own branch for some debugging and the =1B$B!H=1B(=
BChecking hihope-rzg2m-buster.dpkg_status=1B$B!I=1B(B line seems to take an=
 extremely long time.

Either that or it=1B$B!G=1B(Bs done, and now it=1B$B!G=1B(Bs doing the aws =
s3 sync that=1B$B!G=1B(Bs done afterwards, and this is the step that is tak=
ing forever.



Indeed, looking at your job linked below, it took 49 minutes to the point w=
here it failed.



How long does it take to run the cve-check script locally?

Outside of the specific issue you=1B$B!G=1B(Bre seeing, if it=1B$B!G=1B(Bs =
very CPU intensive then perhaps we=1B$B!G=1B(Bre better to use the =1B$B!H=
=1B(Blarge=1B$B!I=1B(B runners?



Kind regards, Chris



From: Sai.Sathujoda@toshiba-tsip.com <Sai.Sathujoda@toshiba-tsip.com>
Sent: Wednesday, September 25, 2024 10:57 AM
To: Chris Paterson <Chris.Paterson2@renesas.com>; michael.adler@siemens.com
Cc: kazuhiro3.hayashi@toshiba.co.jp; dinesh.kumar@toshiba-tsip.com; cip-dev=
@lists.cip-project.org
Subject: Re: [cip-dev] Issue with 'small' Gitlab runners



Hello Chris,



This issue is still present in small runners. I ran the cve-checks job toda=
y. https://gitlab.com/cip-project/cip-core/isar-cip-core/-/jobs/7885795173#=
L655



It still shows 'Job failed (system failure): pods "runner-zwslwy9eu-project=
-10191315-concurrent-0-ulyylb1h" not found'.



Thanks and regards,

Sai Ashrith Sathujoda

________________________________

From: Chris Paterson <Chris.Paterson2@renesas.com<mailto:Chris.Paterson2@re=
nesas.com>>
Sent: Wednesday, September 25, 2024 3:06 PM
To: ashrith sai(=1B$B#T#S#I#P=1B(B) <Sai.Sathujoda@toshiba-tsip.com<mailto:=
Sai.Sathujoda@toshiba-tsip.com>>; michael.adler@siemens.com<mailto:michael.=
adler@siemens.com> <michael.adler@siemens.com<mailto:michael.adler@siemens.=
com>>
Cc: hayashi kazuhiro(=1B$BNS=1B(B =1B$BOB9(=1B(B =1B$B#D#M#E=1B(B =1B$B!{#D=
#I#G""#M#P#S!{#M#P#4=1B(B) <kazuhiro3.hayashi@toshiba.co.jp<mailto:kazuhiro=
3.hayashi@toshiba.co.jp>>; dinesh kumar(=1B$B#T#S#I#P=1B(B TMIEC ODG Portin=
g) <dinesh.kumar@toshiba-tsip.com<mailto:dinesh.kumar@toshiba-tsip.com>>
Subject: RE: [cip-dev] Issue with 'small' Gitlab runners



Hello Sai,

> From: Sai.Sathujoda@toshiba-tsip.com<mailto:Sai.Sathujoda@toshiba-tsip.co=
m> <Sai.Sathujoda@toshiba-tsip.com<mailto:Sai.Sathujoda@toshiba-tsip.com>>
> Sent: Wednesday, September 4, 2024 12:53 PM
>
> Hello Michael,
>
> I ran this job multiple times recently. I am seeing 'pods runner-
> zwslwy9eu-project-10191315-concurrent-0-2fdr4qlb not found issue' again
> while using small runner. https://gitlab.com/cip-project/cip-core/isar-
> cip-core/-/jobs/7740352129

Are you still seeing these issues?

Kind regards, Chris

>
> When I run with large runners, the job is successful ->
> https://gitlab.com/cip-project/cip-core/isar-cip-core/-/jobs/7742283984 .
> That is why I suspected there might be an issue with small runners. Can
> you please provide your opinion on this ?
>
> Regards,
> Sai Ashrith Sathujoda (T S I P)
>
> -----Original Message-----
> From: cip-dev@lists.cip-project.org<mailto:cip-dev@lists.cip-project.org>=
 <cip-dev@lists.cip-project.org<mailto:cip-dev@lists.cip-project.org>> On
> Behalf Of Michael Adler via lists.cip-project.org
> Sent: Monday, September 2, 2024 2:28 PM
> To: cip-dev@lists.cip-project.org<mailto:cip-dev@lists.cip-project.org>
> Cc: Chris.Paterson2@renesas.com<mailto:Chris.Paterson2@renesas.com>; haya=
shi kazuhiro(=1B$BNS=1B(B =1B$BOB9(=1B(B =1B$B#D#M#E=1B(B
> =1B$B!{#D#I#G""#M#P#S!{#M#P#4=1B(B) <kazuhiro3.hayashi@toshiba.co.jp<mail=
to:kazuhiro3.hayashi@toshiba.co.jp>>; dinesh
> kumar(=1B$B#T#S#I#P=1B(B TMIEC ODG Porting) <dinesh.kumar@toshiba-tsip.co=
m<mailto:dinesh.kumar@toshiba-tsip.com>>
> Subject: Re: [cip-dev] Issue with 'small' Gitlab runners
>
> Hi Sai,
>
> > I thought there might be some issue with the runners as the job failure
> message said, =1B$B!H=1B(BThere has been a runner system failure, please =
try again.=1B$B!I=1B(B
>
> maybe there was a temporary issue. I just looked at the cluster and it
> seems to be (idling) fine. So I'd suggest to try it again.
>
> Kind Regards,
>   Michael
>
> --
> Michael Adler
>
> Siemens AG
> Technology
> Connectivity & Edge
> Open Source Embedded Systems
> T CED OES-DE
> Friedrich-Ludwig-Bauer-Str. 3
> 85748 Garching, Germany
>
> Siemens Aktiengesellschaft: Chairman of the Supervisory Board: Jim
> Hagemann Snabe; Managing Board: Roland Busch, Chairman, President and
> Chief Executive Officer; Cedrik Neike, Matthias Rebellius, Ralf P. Thomas=
,
> Judith Wiese; Registered offices: Berlin and Munich, Germany; Commercial
> registries:
> Berlin-Charlottenburg, HRB 12300, Munich, HRB 6684; WEEE-Reg.-No. DE
> 23691322

--_000_OS3PR01MB61038FEE197308A2E5B51F56C2692OS3PR01MB6103jpnp_
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
Hello Chris,</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
<br>
</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
I apologize for an incomplete reply to your question.</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
<br>
</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
I went through your debug pipelines in isar-cip-core. I observed <b>hihope-=
rzg2m-buster.dpkg_status
</b>taking around 9 minutes to generate a cve report&nbsp; in CI while bull=
seye and bookworm targets' cve reports are generated in around 1-2&nbsp;min=
utes. Based on my understanding it is taking a lot of time to generate cve-=
reports from buster targets in CI.</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
<br>
</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
Answering your question, I locally executed cve report generator script in =
my Debian machine (8 cores, Intel(R) Core(TM) i7-9700 CPU @ 3.00GHz)&nbsp;i=
nside a Docker container.&nbsp;</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
<br>
</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
I have no name!@c3cf62622aab:/work$ date</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);">
<b>Wed Sep 25 14:22:23 UTC 2024</b></div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);">
I have no name!@c3cf62622aab:/work$ ./cve_checker.py --suite buster --statu=
s cip-core-image-cip-core-buster-hihope-rzg2m.dpkg_status</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);">
I have no name!@c3cf62622aab:/work$ date</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
<b>Wed Sep 25 14:23:48 UTC 2024</b></div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
<b><br>
</b></div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
The duration is approximately around 90 seconds.</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
<br>
</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
Regards,</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
Sai Ashrith Sathujoda</div>
<div id=3D"appendonsend"></div>
<hr style=3D"display:inline-block;width:98%" tabindex=3D"-1">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" st=
yle=3D"font-size:11pt" color=3D"#000000"><b>From:</b> Chris Paterson &lt;Ch=
ris.Paterson2@renesas.com&gt;<br>
<b>Sent:</b> Wednesday, September 25, 2024 5:13 PM<br>
<b>To:</b> ashrith sai(=1B$B#T#S#I#P=1B(B) &lt;Sai.Sathujoda@toshiba-tsip.c=
om&gt;; michael.adler@siemens.com &lt;michael.adler@siemens.com&gt;<br>
<b>Cc:</b> hayashi kazuhiro(=1B$BNS=1B(B =1B$BOB9(=1B(B =1B$B#D#M#E=1B(B =
=1B$B!{#D#I#G""#M#P#S!{#M#P#4=1B(B) &lt;kazuhiro3.hayashi@toshiba.co.jp&gt;=
; dinesh kumar(=1B$B#T#S#I#P=1B(B TMIEC ODG Porting) &lt;dinesh.kumar@toshi=
ba-tsip.com&gt;; cip-dev@lists.cip-project.org &lt;cip-dev@lists.cip-projec=
t.org&gt;<br>
<b>Subject:</b> RE: [cip-dev] Issue with 'small' Gitlab runners</font>
<div>&nbsp;</div>
</div>
<style>
<!--
@font-face
	{font-family:"Cambria Math"}
@font-face
	{font-family:Calibri}
@font-face
	{font-family:Aptos}
@font-face
	{font-family:"MS PGothic"}
p.x_MsoNormal, li.x_MsoNormal, div.x_MsoNormal
	{margin:0cm;
	font-size:12.0pt;
	font-family:"MS PGothic",sans-serif}
a:link, span.x_MsoHyperlink
	{color:blue;
	text-decoration:underline}
span.x_EmailStyle20
	{font-family:"Calibri",sans-serif;
	color:#7030A0;
	font-weight:normal;
	font-style:normal;
	text-decoration:none none}
.x_MsoChpDefault
	{font-size:10.0pt}
@page WordSection1
	{margin:72.0pt 72.0pt 72.0pt 72.0pt}
div.x_WordSection1
	{}
-->
</style>
<div lang=3D"EN-GB" link=3D"blue" vlink=3D"purple" style=3D"word-wrap:break=
-word">
<div class=3D"x_WordSection1">
<p class=3D"x_MsoNormal"><span style=3D"font-size:11.0pt; font-family:&quot=
;Calibri&quot;,sans-serif; color:#7030A0">Hello Sai,</span></p>
<p class=3D"x_MsoNormal"><span style=3D"font-size:11.0pt; font-family:&quot=
;Calibri&quot;,sans-serif; color:#7030A0">&nbsp;</span></p>
<p class=3D"x_MsoNormal"><span style=3D"font-size:11.0pt; font-family:&quot=
;Calibri&quot;,sans-serif; color:#7030A0">Do you know how long the cve chec=
ks normally take?</span></p>
<p class=3D"x_MsoNormal"><span style=3D"font-size:11.0pt; font-family:&quot=
;Calibri&quot;,sans-serif; color:#7030A0">I=1B$B!G=1B(Bve set up my own bra=
nch for some debugging and the =1B$B!H=1B(BChecking hihope-rzg2m-buster.dpk=
g_status=1B$B!I=1B(B line seems to take an extremely long time.</span></p>
<p class=3D"x_MsoNormal"><span style=3D"font-size:11.0pt; font-family:&quot=
;Calibri&quot;,sans-serif; color:#7030A0">Either that or it=1B$B!G=1B(Bs do=
ne, and now it=1B$B!G=1B(Bs doing the aws s3 sync that=1B$B!G=1B(Bs done af=
terwards, and this is the step that is taking forever.</span></p>
<p class=3D"x_MsoNormal"><span style=3D"font-size:11.0pt; font-family:&quot=
;Calibri&quot;,sans-serif; color:#7030A0">&nbsp;</span></p>
<p class=3D"x_MsoNormal"><span style=3D"font-size:11.0pt; font-family:&quot=
;Calibri&quot;,sans-serif; color:#7030A0">Indeed, looking at your job linke=
d below, it took 49 minutes to the point where it failed.</span></p>
<p class=3D"x_MsoNormal"><span style=3D"font-size:11.0pt; font-family:&quot=
;Calibri&quot;,sans-serif; color:#7030A0">&nbsp;</span></p>
<p class=3D"x_MsoNormal"><span style=3D"font-size:11.0pt; font-family:&quot=
;Calibri&quot;,sans-serif; color:#7030A0">How long does it take to run the =
cve-check script locally?</span></p>
<p class=3D"x_MsoNormal"><span style=3D"font-size:11.0pt; font-family:&quot=
;Calibri&quot;,sans-serif; color:#7030A0">Outside of the specific issue you=
=1B$B!G=1B(Bre seeing, if it=1B$B!G=1B(Bs very CPU intensive then perhaps w=
e=1B$B!G=1B(Bre better to use the =1B$B!H=1B(Blarge=1B$B!I=1B(B runners?</s=
pan></p>
<p class=3D"x_MsoNormal"><span style=3D"font-size:11.0pt; font-family:&quot=
;Calibri&quot;,sans-serif; color:#7030A0">&nbsp;</span></p>
<div>
<p class=3D"x_MsoNormal"><span style=3D"font-size:11.0pt; font-family:&quot=
;Aptos&quot;,sans-serif; color:#7030A0">Kind regards, Chris</span></p>
</div>
<p class=3D"x_MsoNormal"><span style=3D"font-size:11.0pt; font-family:&quot=
;Calibri&quot;,sans-serif; color:#7030A0">&nbsp;</span></p>
<div style=3D"border:none; border-left:solid blue 1.5pt; padding:0cm 0cm 0c=
m 4.0pt">
<div>
<div style=3D"border:none; border-top:solid #E1E1E1 1.0pt; padding:3.0pt 0c=
m 0cm 0cm">
<p class=3D"x_MsoNormal"><b><span lang=3D"EN-US" style=3D"font-size:11.0pt;=
 font-family:&quot;Calibri&quot;,sans-serif">From:</span></b><span lang=3D"=
EN-US" style=3D"font-size:11.0pt; font-family:&quot;Calibri&quot;,sans-seri=
f"> Sai.Sathujoda@toshiba-tsip.com &lt;Sai.Sathujoda@toshiba-tsip.com&gt;
<br>
<b>Sent:</b> Wednesday, September 25, 2024 10:57 AM<br>
<b>To:</b> Chris Paterson &lt;Chris.Paterson2@renesas.com&gt;; michael.adle=
r@siemens.com<br>
<b>Cc:</b> kazuhiro3.hayashi@toshiba.co.jp; dinesh.kumar@toshiba-tsip.com; =
cip-dev@lists.cip-project.org<br>
<b>Subject:</b> Re: [cip-dev] Issue with 'small' Gitlab runners</span></p>
</div>
</div>
<p class=3D"x_MsoNormal">&nbsp;</p>
<div>
<p class=3D"x_MsoNormal"><span style=3D"font-family:&quot;Aptos&quot;,sans-=
serif; color:black">Hello Chris,</span></p>
</div>
<div>
<p class=3D"x_MsoNormal"><span style=3D"font-family:&quot;Aptos&quot;,sans-=
serif; color:black">&nbsp;</span></p>
</div>
<div>
<p class=3D"x_MsoNormal"><span style=3D"font-family:&quot;Aptos&quot;,sans-=
serif; color:black">This issue is still present in small runners. I ran the=
 cve-checks job today.
<a href=3D"https://gitlab.com/cip-project/cip-core/isar-cip-core/-/jobs/788=
5795173#L655">
https://gitlab.com/cip-project/cip-core/isar-cip-core/-/jobs/7885795173#L65=
5</a></span></p>
</div>
<div>
<p class=3D"x_MsoNormal"><span style=3D"font-family:&quot;Aptos&quot;,sans-=
serif; color:black">&nbsp;</span></p>
</div>
<div>
<p class=3D"x_MsoNormal"><span style=3D"font-family:&quot;Aptos&quot;,sans-=
serif; color:black">It still shows '<b>Job failed (system failure): pods &q=
uot;runner-zwslwy9eu-project-10191315-concurrent-0-ulyylb1h&quot; not found=
'.</b></span></p>
</div>
<div>
<p class=3D"x_MsoNormal"><span style=3D"font-family:&quot;Aptos&quot;,sans-=
serif; color:black">&nbsp;</span></p>
</div>
<div>
<p class=3D"x_MsoNormal"><span style=3D"font-family:&quot;Aptos&quot;,sans-=
serif; color:black">Thanks and regards,</span></p>
</div>
<div>
<p class=3D"x_MsoNormal"><span style=3D"font-family:&quot;Aptos&quot;,sans-=
serif; color:black">Sai Ashrith Sathujoda</span></p>
</div>
<div class=3D"x_MsoNormal" align=3D"center" style=3D"text-align:center">
<hr size=3D"2" width=3D"98%" align=3D"center">
</div>
<div id=3D"x_divRplyFwdMsg">
<p class=3D"x_MsoNormal"><b><span style=3D"font-size:11.0pt; font-family:&q=
uot;Calibri&quot;,sans-serif; color:black">From:</span></b><span style=3D"f=
ont-size:11.0pt; font-family:&quot;Calibri&quot;,sans-serif; color:black"> =
Chris Paterson &lt;<a href=3D"mailto:Chris.Paterson2@renesas.com">Chris.Pat=
erson2@renesas.com</a>&gt;<br>
<b>Sent:</b> Wednesday, September 25, 2024 3:06 PM<br>
<b>To:</b> ashrith sai(</span><span lang=3D"JA" style=3D"font-size:11.0pt; =
color:black">=1B$B#T#S#I#P=1B(B</span><span style=3D"font-size:11.0pt; font=
-family:&quot;Calibri&quot;,sans-serif; color:black">) &lt;<a href=3D"mailt=
o:Sai.Sathujoda@toshiba-tsip.com">Sai.Sathujoda@toshiba-tsip.com</a>&gt;;
<a href=3D"mailto:michael.adler@siemens.com">michael.adler@siemens.com</a> =
&lt;<a href=3D"mailto:michael.adler@siemens.com">michael.adler@siemens.com<=
/a>&gt;<br>
<b>Cc:</b> hayashi kazuhiro(</span><span lang=3D"JA" style=3D"font-size:11.=
0pt; color:black">=1B$BNS=1B(B</span><span lang=3D"JA" style=3D"font-size:1=
1.0pt; font-family:&quot;Calibri&quot;,sans-serif; color:black">
</span><span lang=3D"JA" style=3D"font-size:11.0pt; color:black">=1B$BOB9(=
=1B(B</span><span lang=3D"JA" style=3D"font-size:11.0pt; font-family:&quot;=
Calibri&quot;,sans-serif; color:black">
</span><span lang=3D"JA" style=3D"font-size:11.0pt; color:black">=1B$B#D#M#=
E=1B(B</span><span style=3D"font-size:11.0pt; font-family:&quot;Calibri&quo=
t;,sans-serif; color:black"> =1B$B!{=1B(B</span><span lang=3D"JA" style=3D"=
font-size:11.0pt; color:black">=1B$B#D#I#G=1B(B</span><span style=3D"font-s=
ize:11.0pt; font-family:&quot;Calibri&quot;,sans-serif; color:black">=1B$B"=
"=1B(B</span><span lang=3D"JA" style=3D"font-size:11.0pt; color:black">=1B$=
B#M#P#S=1B(B</span><span style=3D"font-size:11.0pt; font-family:&quot;Calib=
ri&quot;,sans-serif; color:black">=1B$B!{=1B(B</span><span lang=3D"JA" styl=
e=3D"font-size:11.0pt; color:black">=1B$B#M#P#4=1B(B</span><span style=3D"f=
ont-size:11.0pt; font-family:&quot;Calibri&quot;,sans-serif; color:black">)
 &lt;<a href=3D"mailto:kazuhiro3.hayashi@toshiba.co.jp">kazuhiro3.hayashi@t=
oshiba.co.jp</a>&gt;; dinesh kumar(</span><span lang=3D"JA" style=3D"font-s=
ize:11.0pt; color:black">=1B$B#T#S#I#P=1B(B</span><span style=3D"font-size:=
11.0pt; font-family:&quot;Calibri&quot;,sans-serif; color:black"> TMIEC
 ODG Porting) &lt;<a href=3D"mailto:dinesh.kumar@toshiba-tsip.com">dinesh.k=
umar@toshiba-tsip.com</a>&gt;<br>
<b>Subject:</b> RE: [cip-dev] Issue with 'small' Gitlab runners</span> </p>
<div>
<p class=3D"x_MsoNormal">&nbsp;</p>
</div>
</div>
<div>
<div>
<p class=3D"x_MsoNormal"><span style=3D"font-size:11.0pt">Hello Sai,<br>
<br>
&gt; From: <a href=3D"mailto:Sai.Sathujoda@toshiba-tsip.com">Sai.Sathujoda@=
toshiba-tsip.com</a> &lt;<a href=3D"mailto:Sai.Sathujoda@toshiba-tsip.com">=
Sai.Sathujoda@toshiba-tsip.com</a>&gt;<br>
&gt; Sent: Wednesday, September 4, 2024 12:53 PM<br>
&gt; <br>
&gt; Hello Michael,<br>
&gt; <br>
&gt; I ran this job multiple times recently. I am seeing 'pods runner-<br>
&gt; zwslwy9eu-project-10191315-concurrent-0-2fdr4qlb not found issue' agai=
n<br>
&gt; while using small runner. <a href=3D"https://gitlab.com/cip-project/ci=
p-core/isar-">
https://gitlab.com/cip-project/cip-core/isar-</a><br>
&gt; cip-core/-/jobs/7740352129<br>
<br>
Are you still seeing these issues?<br>
<br>
Kind regards, Chris<br>
<br>
&gt; <br>
&gt; When I run with large runners, the job is successful -&gt;<br>
&gt; <a href=3D"https://gitlab.com/cip-project/cip-core/isar-cip-core/-/job=
s/7742283984">
https://gitlab.com/cip-project/cip-core/isar-cip-core/-/jobs/7742283984</a>=
 .<br>
&gt; That is why I suspected there might be an issue with small runners. Ca=
n<br>
&gt; you please provide your opinion on this ?<br>
&gt; <br>
&gt; Regards,<br>
&gt; Sai Ashrith Sathujoda (T S I P)<br>
&gt; <br>
&gt; -----Original Message-----<br>
&gt; From: <a href=3D"mailto:cip-dev@lists.cip-project.org">cip-dev@lists.c=
ip-project.org</a> &lt;<a href=3D"mailto:cip-dev@lists.cip-project.org">cip=
-dev@lists.cip-project.org</a>&gt; On<br>
&gt; Behalf Of Michael Adler via lists.cip-project.org<br>
&gt; Sent: Monday, September 2, 2024 2:28 PM<br>
&gt; To: <a href=3D"mailto:cip-dev@lists.cip-project.org">cip-dev@lists.cip=
-project.org</a><br>
&gt; Cc: <a href=3D"mailto:Chris.Paterson2@renesas.com">Chris.Paterson2@ren=
esas.com</a>; hayashi kazuhiro(<span lang=3D"JA">=1B$BNS=1B(B =1B$BOB9(=1B(=
B =1B$B#D#M#E=1B(B</span><br>
&gt; =1B$B!{=1B(B<span lang=3D"JA">=1B$B#D#I#G=1B(B</span>=1B$B""=1B(B<span=
 lang=3D"JA">=1B$B#M#P#S=1B(B</span>=1B$B!{=1B(B<span lang=3D"JA">=1B$B#M#P=
#4=1B(B</span>) &lt;<a href=3D"mailto:kazuhiro3.hayashi@toshiba.co.jp">kazu=
hiro3.hayashi@toshiba.co.jp</a>&gt;; dinesh<br>
&gt; kumar(<span lang=3D"JA">=1B$B#T#S#I#P=1B(B</span> TMIEC ODG Porting) &=
lt;<a href=3D"mailto:dinesh.kumar@toshiba-tsip.com">dinesh.kumar@toshiba-ts=
ip.com</a>&gt;<br>
&gt; Subject: Re: [cip-dev] Issue with 'small' Gitlab runners<br>
&gt; <br>
&gt; Hi Sai,<br>
&gt; <br>
&gt; &gt; I thought there might be some issue with the runners as the job f=
ailure<br>
&gt; message said, =1B$B!H=1B(BThere has been a runner system failure, plea=
se try again.=1B$B!I=1B(B<br>
&gt; <br>
&gt; maybe there was a temporary issue. I just looked at the cluster and it=
<br>
&gt; seems to be (idling) fine. So I'd suggest to try it again.<br>
&gt; <br>
&gt; Kind Regards,<br>
&gt;&nbsp;&nbsp; Michael<br>
&gt; <br>
&gt; --<br>
&gt; Michael Adler<br>
&gt; <br>
&gt; Siemens AG<br>
&gt; Technology<br>
&gt; Connectivity &amp; Edge<br>
&gt; Open Source Embedded Systems<br>
&gt; T CED OES-DE<br>
&gt; Friedrich-Ludwig-Bauer-Str. 3<br>
&gt; 85748 Garching, Germany<br>
&gt; <br>
&gt; Siemens Aktiengesellschaft: Chairman of the Supervisory Board: Jim<br>
&gt; Hagemann Snabe; Managing Board: Roland Busch, Chairman, President and<=
br>
&gt; Chief Executive Officer; Cedrik Neike, Matthias Rebellius, Ralf P. Tho=
mas,<br>
&gt; Judith Wiese; Registered offices: Berlin and Munich, Germany; Commerci=
al<br>
&gt; registries:<br>
&gt; Berlin-Charlottenburg, HRB 12300, Munich, HRB 6684; WEEE-Reg.-No. DE<b=
r>
&gt; 23691322</span></p>
</div>
</div>
</div>
</div>
</div>
</body>
</html>

--_000_OS3PR01MB61038FEE197308A2E5B51F56C2692OS3PR01MB6103jpnp_--


