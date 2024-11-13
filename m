Return-Path: <sai.sathujoda@toshiba-tsip.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04038D42BB1
	for <webhook@archiver.kernel.org>; Wed, 13 Nov 2024 04:18:18 +0000 (UTC)
Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.158])
 by mx.groups.io with SMTP id smtpd.web10.4345.1731471496656280681
 for <cip-dev@lists.cip-project.org>;
 Tue, 12 Nov 2024 20:18:17 -0800
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: toshiba-tsip.com, ip: 210.130.202.158, mailfrom: sai.sathujoda@toshiba-tsip.com)
Received: by mo-csw.securemx.jp (mx-mo-csw1122) id 4AD4IDwt1892634; Wed, 13 Nov 2024 13:18:13 +0900
X-Iguazu-Qid: 2rWhPuvTEStA3Lp16o
X-Iguazu-QSIG: v=2; s=0; t=1731471493; q=2rWhPuvTEStA3Lp16o; m=ggXBKU2BiCl7zWBSBG7cgYOBsUJZF8EIVFYP9zdDB+Q=
Received: from imx2-a.toshiba.co.jp (imx2-a.toshiba.co.jp [106.186.93.35])
	by relay.securemx.jp (mx-mr1123) id 4AD4IBFr2247129
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Wed, 13 Nov 2024 13:18:12 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZcmWaCT1/g5HF8iU6b5NAzzIaGQgYeIP5s/0UEWWj14QQRbxmZhaYmdHse5vexG2FavL+YBATCDDlRZru1WyVFUn5+7nW3VRP7gIWrrA1Fcf11NymYodWFU7rAL0E8KUGDoFeG8Nnbm/9QOAWNtbzSXMgI1D7a/RjFglf9FoeQLfEO3QKHUwpdoN+kDfbeGk1wp6mk7AZ6Ql/1PhQ1yh65EKC/K95woIJiiHAPWC/qMNhZHDTQhHrT8x06shrJX/HC9lXUnbllxo+RKgMKqVgLOr68rm8DKSmpJimsHC6opT7QB6/yjLsXRFxluM7ZQMoyR/l/CmzwZLzOHE1Bwe7A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ebNIVVs6ZX32WQk6CY0J63/v2IpKwla7NyPm4zQucrU=;
 b=fj9Iufg2rqUb+cC4vF1aJKySdK5yqlblXvrX49H0/d3rewe6SfdJDEY71aOQ95mZ0tvy3To2DaAPPjCG3fCbeeXwYLr5H1RzF4XG0f4q3jATnre3HPkoeAO94k27dCtnNCJ2quQH6MWw0kH8qjE7QNKuMfyOzT253D7pQIrspLf5EEagWSY5Qf7GVnUifYW9WON2X4BJEoVXPZbUQI24Sb+j6NanLowInmdftBRrw6NvOaqAPWy6GaO8U1KER0MCmX62l57EHCX0Tp0xeK2xQOOQCnHi7y2+EdLRvyKPfhhbQ4vRkcTPYatw1K3dW5XSg0fujt2zDfyhGgi6xJ5DhA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=toshiba-tsip.com; dmarc=pass action=none
 header.from=toshiba-tsip.com; dkim=pass header.d=toshiba-tsip.com; arc=none
From: <Sai.Sathujoda@toshiba-tsip.com>
To: <Chris.Paterson2@renesas.com>
CC: <nobuhiro1.iwamatsu@toshiba.co.jp>, <kazuhiro3.hayashi@toshiba.co.jp>,
        <dinesh.kumar@toshiba-tsip.com>, <cip-dev@lists.cip-project.org>,
        <cip-security@lists.cip-project.org>
Subject: Re: [cip-dev] Manually run Kernel and IEC tests on M-COM x86 and
 generate results
Thread-Topic: [cip-dev] Manually run Kernel and IEC tests on M-COM x86 and
 generate results
Thread-Index: AQHbNLcv3vC8deZB0Ua07zkQ6b5nXrKzrb4QgADt2YQ=
Date: Wed, 13 Nov 2024 04:18:08 +0000
X-TSB-HOP2: ON
Message-ID: 
 <OS3PR01MB61038BEADC4DF70538303B6BC25A2@OS3PR01MB6103.jpnprd01.prod.outlook.com>
References: 
 <OS3PR01MB6103AC4F03F328776A6DFBCBC2592@OS3PR01MB6103.jpnprd01.prod.outlook.com>
 <TYYPR01MB1240281691D569EB3FFF1BF46B7592@TYYPR01MB12402.jpnprd01.prod.outlook.com>
In-Reply-To: 
 <TYYPR01MB1240281691D569EB3FFF1BF46B7592@TYYPR01MB12402.jpnprd01.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=toshiba-tsip.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OS3PR01MB6103:EE_|OSZPR01MB8703:EE_
x-ms-office365-filtering-correlation-id: d727e056-68a3-4776-5273-08dd039a2e18
x-ld-processed: f109924e-fb71-4ba0-b2cc-65dcdf6fbe4f,ExtAddr,ExtFwd
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: 
 BCL:0;ARA:13230040|1800799024|366016|376014|8096899003|38070700018;
x-microsoft-antispam-message-info: 
 =?iso-2022-jp?B?TEhheENld08raWluMVJ4RFRzWWpoQ0dpd1AveXJLaWtDakVXYWJ0NnFr?=
 =?iso-2022-jp?B?QlgxcmMyeUt0YTFydnJacHRwSmdaQkM5d3RlQVlCYlcwajBMaFJQKysr?=
 =?iso-2022-jp?B?N2Y1SDdMc3JCaGF4cXFielBJVkU4Y3JkeTdrazduSmxNYndHSU90TUtm?=
 =?iso-2022-jp?B?SXFYSjNSa1dsNVcxVVl4MHRGNzBJQnM5VXIrMTlUaC9kdjlTTEZCR2x5?=
 =?iso-2022-jp?B?Vzd3aTdlRk5iUS9lQTIvK2N5V1RQZEVlQW9OK0N2bVNtL05JK1VwUElX?=
 =?iso-2022-jp?B?WWt0UEJ0MU51NjJPOEwzR0JoL0VabmlEQk1XcTA4cHVGeit5RlBPWmlM?=
 =?iso-2022-jp?B?RmdWRVk0LzM3Y05kemxyWiswVEp2RlVHNC9tWXZ5UGtvUGdwYjZubUlO?=
 =?iso-2022-jp?B?K3dKQmFZekJHOW8zK1BuTlBscVBpd29nVE5tVitBbEpYSlpLTEFzUXNw?=
 =?iso-2022-jp?B?WEF6ell2TkxCdUxhR3ZRV3BiYlBQRGY2V0pjd2FrMVM2OWtkM3JRK0lC?=
 =?iso-2022-jp?B?V1IwTUNpL0xpUzN0U1h2U09IcERaMlZzcloxZDMzYkJVMCtmUW1jZm14?=
 =?iso-2022-jp?B?S1FLandnbVpWOEMvdzdUOHVJMURMMm9SZGx2WnRYZHNGUHYvdkQ2dnN0?=
 =?iso-2022-jp?B?LzZSdGFvTjd3dGgweWg0cXJFdnQ1YkRXOXZLVVkzS290THBxcStRbXlo?=
 =?iso-2022-jp?B?WmFWQWJlNDF6WUlYd2E5U2NnTDg4b0dpNjA3dzRSc1dnSVZFb0lmSm5B?=
 =?iso-2022-jp?B?NENLNDhzdkpjaEhZa1NxMzBUUjhqOGtSZ3Zhd24zeEY3OW5BNzBtMnVW?=
 =?iso-2022-jp?B?MmJaUThoUWI1N2NVMjhQSzRuS1VjNkgwOXFpaFE3TlJvSFlDZW53RDBh?=
 =?iso-2022-jp?B?ZXAvUnFJK3h5S0cxeDRMMnZ5V2FXUFNscW4vVmtlZ1BRc3Y5a0JIM0Nm?=
 =?iso-2022-jp?B?b2pLZjM4V2dNZm5nd0VvYk1QR1J6Z0oxd25EQ1U4QXB6a3lRZ0Z1RUlG?=
 =?iso-2022-jp?B?K0orWnBhOFd6MWlEWWtGSEZwa0hWSEtBb3pMVjNWMFZkZWs5K1F4bHgr?=
 =?iso-2022-jp?B?TjNaNnprVkNVUnRTWGl3MnVrR2c5N21lYlpJLzFHbU5NZG5xL0l6OWE5?=
 =?iso-2022-jp?B?eXRtUXIvNm9hYlF5U3VjdjcvOUQ3dEFySkRSVEU4RFVDcjB6YnVpUXp5?=
 =?iso-2022-jp?B?L0lzT1ZHTDJUK2p4MmVMQS81WHowcDk4ZENwdzFZU0UxWkVnaFVzZXUz?=
 =?iso-2022-jp?B?eWkwditiSUN3VTB2MEE1T3VpRU5TWEJ4WnBFUGVVNEpIcEJEVUdwZE8y?=
 =?iso-2022-jp?B?c1lwM1RFMmNNYVpDQmp1RUdmNUVVa0kzWUN6bkZUWmFIZEZrUkMxTTRa?=
 =?iso-2022-jp?B?QVhBZlE1bFZLQ1hCUmtubnFyQ3VnMW4yWjgvK1ZsR0lteTQxR1ZCb0px?=
 =?iso-2022-jp?B?RzBoc1NUUGFmTUloT2dqSTdNVTFZRmVsamIrNmloR2pZZFJYekpQc085?=
 =?iso-2022-jp?B?SVpXeTBkbnhlVS9iMktwb3M1QTBNMStMYnJVSjRSakU2empacmdOUm5o?=
 =?iso-2022-jp?B?Z3NISWYwMy9vUFBxeHdubG9qbXdnQktGdGFxQldDTDBlWGdYUC9VWjdP?=
 =?iso-2022-jp?B?VXF1Y3JveW9DY3R6anBYbjcwQTFyS2xpdm1taVRKZ1JuZ2c4UnZjUmpw?=
 =?iso-2022-jp?B?Z0JwbjBEbXlDWGlHSlhlclhjQ1VLT1VxY1ovVjFBTnF3aURwRWpWREJw?=
 =?iso-2022-jp?B?L2RMakI1RkVXNjMwS0Q4SmtZTnlvWUdEUzVUVlU0WmtZRjVBMFZ3R1pY?=
 =?iso-2022-jp?B?T3RYdm44aGFheVRtVWVYNTA0N2ZEZGNjamxoS25EZUJjanNTR2xOTklX?=
 =?iso-2022-jp?B?RnE4STlOTjdTTFZrSEVucW9YRmh1b0lLeS9Xbk9Gcm9KME4yZWRJeWtx?=
 =?iso-2022-jp?B?WC9NaEdMZDIxMm1oR1ZKUWJ6OER1UT09?=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:ja;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS3PR01MB6103.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(8096899003)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?iso-2022-jp?B?N0xRd1Ewa2w4MFdXRVEvbnkxSTZncUZ1OGlubzQvVm5XMG5qMGxhSzdW?=
 =?iso-2022-jp?B?dm96dCttSVN6ZlhsK1dDck9yNWpnVjA1R3l6RmprMXh4ZGtrVytaaUZ0?=
 =?iso-2022-jp?B?bTk1Mi9mTzJaSFd3bjVYTGNkOXE0aXVnU1Z5WlFHK2ZWNHordVJ2WnVN?=
 =?iso-2022-jp?B?MWNySit3SXdtU1VGUUZLcDdIZkE1T2I4MGN1a1ovWGtRVm9vNEQzSlJQ?=
 =?iso-2022-jp?B?WUM3WjVBOWJNNm1tVTBnamtGUmZoV2QzejZ4a05kOEFjdGlIUWhhRUVQ?=
 =?iso-2022-jp?B?RStFVDY4YkZKSk9IVGpGVkMwNXFlcGVJajlJaVBoaWdxdUV0a2YxcVoy?=
 =?iso-2022-jp?B?ZkFtT01xam9IYUpXZGx5OTZqUmNYcXpXOEx1eXZBbVVOU0phV2lHYVV4?=
 =?iso-2022-jp?B?TDNBOFYrYjFRUmFzUHpBWmxadGpYakd3dEl0ZExpNnd4Y3FBUjZ6RzFL?=
 =?iso-2022-jp?B?RnNaZUNqWjc4Q2VtVVBGa044TmdrNnBITzdpcDNzQ3pyOHVBUnJHeEM0?=
 =?iso-2022-jp?B?MkJpMFplRWY5YkxpWEdMRkg1TUFmaTZLaFFkRm5ObG9lK2xRVjFZZTlV?=
 =?iso-2022-jp?B?WjZsa0RsMGdGaytZYUk4OW14R3U1bi9EQ2QyVkgzZ29VUmZIcW9jeWt0?=
 =?iso-2022-jp?B?T2NiT3N5YTNpRFhDUjhWLzF0R3JlWjl5TG5laXRBTEwyTFQ3Q1ZMd0Fm?=
 =?iso-2022-jp?B?eWlqam0rOHQwb2I5cXlmRXdCQ2JxUUJ4Rk5QOVB4NEVNcTFQWDBoU3ly?=
 =?iso-2022-jp?B?K3d2bWlvaXJNdzVldEdDOTU4MkltbEJiY2lveUxlQ1ZzNEd3MU93TEla?=
 =?iso-2022-jp?B?cVNWNzdJdFF5RmcwQ2dVOXlHUU14b0RESDZUdlIzWTAxNjNHNFl1Z2Fo?=
 =?iso-2022-jp?B?M09FNm1qdjNYZ1ZBRWk0c3d0c1lRVTVSaFlRUWJEWjhUQmc0bVE0RXBl?=
 =?iso-2022-jp?B?Rnh6a0I2ZmlCN0tIcWlrTFRNeTR2S0NVT2xSQnZ3NlY5ZWovdnl0MFJC?=
 =?iso-2022-jp?B?NFhkZDFaaldHZm9SZm9saUhrNXdRZVg2ekhDRUtVUmEzclJpdGIzdytL?=
 =?iso-2022-jp?B?NGYzc2NHQ1ZqQ1M3NHlrNlE3L2FTVFlTK05VeExJaGxsaE81dEJNeVFQ?=
 =?iso-2022-jp?B?MGRDK1h0eGpqVzVJR1lUQmh1NHBpT1pVTWlUcWZHakZIbTVRRzliL2Rr?=
 =?iso-2022-jp?B?MGR0ZVdHcHJEbEpHRUExTjJtRTNLMXF1TnNsRktlY0hBMEJ3Um5ya05F?=
 =?iso-2022-jp?B?M3F1MXN6WFl5ZFdRbFlOd3RMWVFYdjVZQ29GSlJ6S2R0dUVZSmQ2Wkcr?=
 =?iso-2022-jp?B?ZEdEODU1TW5oekdZNGMvRHMxbFhQYk8ra3NPUWpHaTc5TFJpS3pDUHRY?=
 =?iso-2022-jp?B?dldKckZHUlhBU1BjTFJHeVVsNUJCbC9qTXNMbjdxakpaU0Y0NVY4Tmgz?=
 =?iso-2022-jp?B?V1ZnUTEzREZPSElyRFlLaDRlb3RQUENXaEIycGV0dTJ0TDhvdzdzREZ1?=
 =?iso-2022-jp?B?eWhDUXdKeVNPOFhEWVFGWk5IaFQ3bUMzdGhXVUQyNm00OThMODB2bkpW?=
 =?iso-2022-jp?B?SVR3enRUcHorY254YXNTblJmN3oyT1lDRHNKSGhCaW0zWUhxa0MwZzBS?=
 =?iso-2022-jp?B?ais0REpvNktMZThZcTdSK1dUbUNSNGVQUGI3NzNKWkkzRHVjYXJpNGM1?=
 =?iso-2022-jp?B?R1JPbjlzV2JrL0oyKzBZcHdMT2l6NWVVaEpmOGIvMkoydEJNeDBDbFJ2?=
 =?iso-2022-jp?B?SGUzRUZHcW1kWWU5RmcvbVIxZ1k1cTFiZTFodTVRNlNLRi9Xa3NNaUtW?=
 =?iso-2022-jp?B?U21PZ0dTL3JuMVR0NHBmYmVzdDdXN2thSVVtRCtodGtkRWF4aFMzRU9t?=
 =?iso-2022-jp?B?bS95QXdiVGpNL2tqZk50Mkk5U1RobDU2R05GeDMraEppOUVjY2VIalF0?=
 =?iso-2022-jp?B?WW5GbHorMmw1alZEZGlRVnhJajJKWHlnRjQ1eGlmMVB4QWpNSHgyVGEx?=
 =?iso-2022-jp?B?L2hmZXN5MFAxRmNvQVVSOS9ic1RjTGpadHByV3pHUlI1ekw0Q09YY0Ju?=
 =?iso-2022-jp?B?TitGV0pTR2hNdjBvekR3dTZmKy9kRmp4bUI1cytuSWgvVUJzMmNqNnU2?=
 =?iso-2022-jp?B?L3AwMzBwbU9hQWlsb0NSMmNaN3FidWFZZzhuVGtkM2V6Y1l5VHRqTDVl?=
 =?iso-2022-jp?B?QVRZYkwrMS9xK1Bxd2lsR3huUmNrbmVQdnMyVmRRUkNqR0VmekM0TW1s?=
 =?iso-2022-jp?B?b2lKRklSZ3E2b2FQWVRMaWlMRVErWHhtK3hEbkFkYkZVRWcxWW9HWlZa?=
 =?iso-2022-jp?B?L2ZxcHdSb2RaeTZJbzcySk9oLy9MMnMvR0E9PQ==?=
Content-Type: multipart/alternative;
	boundary="_000_OS3PR01MB61038BEADC4DF70538303B6BC25A2OS3PR01MB6103jpnp_"
MIME-Version: 1.0
X-OriginatorOrg: toshiba-tsip.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OS3PR01MB6103.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d727e056-68a3-4776-5273-08dd039a2e18
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Nov 2024 04:18:08.9111
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f109924e-fb71-4ba0-b2cc-65dcdf6fbe4f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: T20WW1W3X+vtX8Tj8pJFtTgyh+JOpujbsWTsX7v2PTBq8BMGGrdszf0CAK5aaUpEIOgRYjCcAUsycpAzqs9LAOuY7LAe7e+3wtyrOoAjdnY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSZPR01MB8703
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 13 Nov 2024 04:18:18 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/17243

--_000_OS3PR01MB61038BEADC4DF70538303B6BC25A2OS3PR01MB6103jpnp_
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable

Hello Chris,

Thank you for the response. I will try with different rootfs to run LTP tes=
ts on M-COM x86 device on LAVA.

Regards,
Sai Ashrith

________________________________
From: cip-dev@lists.cip-project.org <cip-dev@lists.cip-project.org> on beha=
lf of Chris Paterson via lists.cip-project.org <chris.paterson2=3Drenesas.c=
om@lists.cip-project.org>
Sent: Tuesday, November 12, 2024 7:39 PM
To: cip-security@lists.cip-project.org <cip-security@lists.cip-project.org>=
; iwamatsu nobuhiro(=1B$B4d>>=1B(B =1B$B?.MN=1B(B =1B$B!{#D#I#T#C""#D#I#T!{=
#O#S#T=1B(B) <nobuhiro1.iwamatsu@toshiba.co.jp>
Cc: cip-dev@lists.cip-project.org <cip-dev@lists.cip-project.org>; hayashi =
kazuhiro(=1B$BNS=1B(B =1B$BOB9(=1B(B =1B$B#D#M#E=1B(B =1B$B!{#D#I#G""#M#P#S=
!{#M#P#4=1B(B) <kazuhiro3.hayashi@toshiba.co.jp>; dinesh kumar(=1B$B#T#S#I#=
P=1B(B TMIEC ODG Porting) <dinesh.kumar@toshiba-tsip.com>
Subject: Re: [cip-dev] Manually run Kernel and IEC tests on M-COM x86 and g=
enerate results

Hello Sai,

> From: cip-security@lists.cip-project.org <cip-security@lists.cip-
> project.org> On Behalf Of sai ashrith sathujoda via lists.cip-project.org
> Sent: 12 November 2024 04:14
>
> Hello Chris,
>
> Hope you are doing well.
>
> Regarding IEC 62443-4-2 certification, the certification body has asked
> for Kernel and IEC test results on M-COM device. Based on my current
> knowldege, I believe that the test suites mentioned here
> https://gitlab.com/cip-project/cip-testing/linux-cip-ci/-
> /blob/master/submit_tests.sh?ref_type=3Dheads#L55 <https://gitlab.com/cip=
-
> project/cip-testing/linux-cip-ci/-
> /blob/master/submit_tests.sh?ref_type=3Dheads#L55>  shall run for every
> updated kernel image on different CIP reference hardware in LAVA.
>
> Since availability of M-COM device on CIP LAVA Lab still needs some time,
> we are manually running each test suite i.e SMC, Smoke, LTP etc. from
> https://github.com/kernelci/test-definitions

As Jan said - we now have one in CIP's LAVA.
If you have issues using it please let me know.

>
> There are no issues with running SMC, Smoke tests but while running LTP
> tests it is trying to install some dependency packages to the root file
> system. Currently it shows it is a network issue but even if it gets
> resolved, the packages cannot be installed because the security image has
> read-only root file system.

So you'd either have to use a writable filesystem or pre-install everything=
 into the original image.

>
> Another idea which needs to be discussed is, since Kernel tests by name
> means focusing on testing only the Kernel, we can try to use a different
> root file system to run these tests. But this is just an idea, this needs
> to internally be discussed within SWG and with Certification body.

There's no harm in using a different rootfs, or in improving the one curren=
tly used for Kernel testing.
Indeed I believe Iwamatsu-san created separate images for LTP testing previ=
ously anyway.

>
> I request you to provide any suggestions regarding the attached LTP
> issues.

You'd need a working internet connection to solve the specific issues in th=
at log.

Kind regards, Chris

>
> Thanks and regards,
> Sai Ashrith (T S I P)
>

--_000_OS3PR01MB61038BEADC4DF70538303B6BC25A2OS3PR01MB6103jpnp_
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
Thank you for the response. I will try with different rootfs to run LTP tes=
ts on M-COM x86 device on LAVA.</div>
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
Sai Ashrith</div>
<div id=3D"appendonsend"></div>
<div style=3D"font-family:Aptos,Aptos_EmbeddedFont,Aptos_MSFontService,Cali=
bri,Helvetica,sans-serif; font-size:12pt; color:rgb(0,0,0)">
<br>
</div>
<hr tabindex=3D"-1" style=3D"display:inline-block; width:98%">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" co=
lor=3D"#000000" style=3D"font-size:11pt"><b>From:</b> cip-dev@lists.cip-pro=
ject.org &lt;cip-dev@lists.cip-project.org&gt; on behalf of Chris Paterson =
via lists.cip-project.org &lt;chris.paterson2=3Drenesas.com@lists.cip-proje=
ct.org&gt;<br>
<b>Sent:</b> Tuesday, November 12, 2024 7:39 PM<br>
<b>To:</b> cip-security@lists.cip-project.org &lt;cip-security@lists.cip-pr=
oject.org&gt;; iwamatsu nobuhiro(=1B$B4d>>=1B(B =1B$B?.MN=1B(B =1B$B!{#D#I#=
T#C""#D#I#T!{#O#S#T=1B(B) &lt;nobuhiro1.iwamatsu@toshiba.co.jp&gt;<br>
<b>Cc:</b> cip-dev@lists.cip-project.org &lt;cip-dev@lists.cip-project.org&=
gt;; hayashi kazuhiro(=1B$BNS=1B(B =1B$BOB9(=1B(B =1B$B#D#M#E=1B(B =1B$B!{#=
D#I#G""#M#P#S!{#M#P#4=1B(B) &lt;kazuhiro3.hayashi@toshiba.co.jp&gt;; dinesh=
 kumar(=1B$B#T#S#I#P=1B(B TMIEC ODG Porting) &lt;dinesh.kumar@toshiba-tsip.=
com&gt;<br>
<b>Subject:</b> Re: [cip-dev] Manually run Kernel and IEC tests on M-COM x8=
6 and generate results</font>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt"=
>
<div class=3D"PlainText">Hello Sai,<br>
<br>
&gt; From: cip-security@lists.cip-project.org &lt;cip-security@lists.cip-<b=
r>
&gt; project.org&gt; On Behalf Of sai ashrith sathujoda via lists.cip-proje=
ct.org<br>
&gt; Sent: 12 November 2024 04:14<br>
&gt; <br>
&gt; Hello Chris,<br>
&gt; <br>
&gt; Hope you are doing well.<br>
&gt; <br>
&gt; Regarding IEC 62443-4-2 certification, the certification body has aske=
d<br>
&gt; for Kernel and IEC test results on M-COM device. Based on my current<b=
r>
&gt; knowldege, I believe that the test suites mentioned here<br>
&gt; <a href=3D"https://gitlab.com/cip-project/cip-testing/linux-cip-ci/-" =
data-auth=3D"NotApplicable">
https://gitlab.com/cip-project/cip-testing/linux-cip-ci/-</a><br>
&gt; /blob/master/submit_tests.sh?ref_type=3Dheads#L55 &lt;https://gitlab.c=
om/cip-<br>
&gt; project/cip-testing/linux-cip-ci/-<br>
&gt; /blob/master/submit_tests.sh?ref_type=3Dheads#L55&gt;&nbsp; shall run =
for every<br>
&gt; updated kernel image on different CIP reference hardware in LAVA.<br>
&gt; <br>
&gt; Since availability of M-COM device on CIP LAVA Lab still needs some ti=
me,<br>
&gt; we are manually running each test suite i.e SMC, Smoke, LTP etc. from<=
br>
&gt; <a href=3D"https://github.com/kernelci/test-definitions" data-auth=3D"=
NotApplicable">
https://github.com/kernelci/test-definitions</a><br>
<br>
As Jan said - we now have one in CIP's LAVA.<br>
If you have issues using it please let me know.<br>
<br>
&gt; <br>
&gt; There are no issues with running SMC, Smoke tests but while running LT=
P<br>
&gt; tests it is trying to install some dependency packages to the root fil=
e<br>
&gt; system. Currently it shows it is a network issue but even if it gets<b=
r>
&gt; resolved, the packages cannot be installed because the security image =
has<br>
&gt; read-only root file system.<br>
<br>
So you'd either have to use a writable filesystem or pre-install everything=
 into the original image.<br>
<br>
&gt; <br>
&gt; Another idea which needs to be discussed is, since Kernel tests by nam=
e<br>
&gt; means focusing on testing only the Kernel, we can try to use a differe=
nt<br>
&gt; root file system to run these tests. But this is just an idea, this ne=
eds<br>
&gt; to internally be discussed within SWG and with Certification body.<br>
<br>
There's no harm in using a different rootfs, or in improving the one curren=
tly used for Kernel testing.<br>
Indeed I believe Iwamatsu-san created separate images for LTP testing previ=
ously anyway.<br>
<br>
&gt; <br>
&gt; I request you to provide any suggestions regarding the attached LTP<br=
>
&gt; issues.<br>
<br>
You'd need a working internet connection to solve the specific issues in th=
at log.<br>
<br>
Kind regards, Chris<br>
<br>
&gt; <br>
&gt; Thanks and regards,<br>
&gt; Sai Ashrith (T S I P)<br>
&gt; <br>
</div>
</span></font></div>
</body>
</html>

--_000_OS3PR01MB61038BEADC4DF70538303B6BC25A2OS3PR01MB6103jpnp_--


