Return-Path: <nobuhiro1.iwamatsu@toshiba.co.jp>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3596EC83F17
	for <webhook@archiver.kernel.org>; Tue, 15 Jul 2025 01:16:50 +0000 (UTC)
Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.132])
 by mx.groups.io with SMTP id smtpd.web11.4147.1752542204055847910
 for <cip-dev@lists.cip-project.org>;
 Mon, 14 Jul 2025 18:16:44 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=nobuhiro1.iwamatsu@toshiba.co.jp header.s=key1.smx header.b=iCqhfmi5;
 spf=pass (domain: toshiba.co.jp, ip: 210.130.202.132, mailfrom: nobuhiro1.iwamatsu@toshiba.co.jp)
DKIM-Signature: v=1;a=rsa-sha256;c=relaxed/simple;d=toshiba.co.jp;h=From:To:CC
	:Subject:Date:Message-ID:References:In-Reply-To:Content-Type:
	Content-Transfer-Encoding:MIME-Version;i=nobuhiro1.iwamatsu@toshiba.co.jp;s=
	key1.smx;t=1752542194;x=1753751794;bh=3KRYBBBrBk94QaRd7ocdCYwrKV1WxQR2gf+1mcQ
	rqo8=;b=iCqhfmi5NZ4KPYYl0PVWZIm8RpDuf6ngrcnNtZFyuvvdX1qen0arFAFZcNdg6Vn9iBBfU
	QOZWcPoaW+HJNRCTlKnAAT4ZXsjcaqmuYNsiUduQgK8E5VdAloDPHzwljBqBcI2jVLmheJbw3mccP
	p8P8fClGbBvNNCcuedVnBB08qtzyEgwxfHLVgEELrU168t83Vhcf57FXlVIFufJD2cjfC6fl+6VqZ
	R6F/mOflGTZu52e6p8J8VlSANnWSMtZyTI4KKwiuRAL18WIj2AT4Qbagiuui4Xxt8b7RHExmlGPnS
	MhAlD6iEFcxV1uFLv43GI4mcBbtJ0gAg8IzQvxIv6Q==;
Received: by mo-csw.securemx.jp (mx-mo-csw1121) id 56F1GYWr4026437; Tue, 15 Jul 2025 10:16:34 +0900
X-Iguazu-Qid: 2rWhyCKR8yyfL1FWLr
X-Iguazu-QSIG: v=2; s=0; t=1752542193; q=2rWhyCKR8yyfL1FWLr; m=ZKkmeDHlBLNboGHMpKp6xaXg3ra52PFOayzzSJr1tL0=
Received: from imx12-a.toshiba.co.jp ([38.106.60.135])
	by relay.securemx.jp (mx-mr1121) id 56F1GWgo1387720
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Tue, 15 Jul 2025 10:16:32 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qvmOKPmMG8vxHz2xpC23nI5DsgJqVvPwmNsepOStCKFRxa2ukt27AO0YYZMqTJutQ+UvSmYeFMp6XPELbDtpHZS5kIb/P3SgDOcqqSAzmThWePqYTZ4wPo+oyECtCWnVNUWhenB8kMaf7n94dUpVFXufvMJ5GYXP/YTdtZgsrsnzuDk+WuxIaivJ6v0V+jUEt2WT9K5/PsGF3KkHI/VZP1bjWUDl/4WwR4D65k1AZ6TgQB9eKCLRuvdfoXh8jxEvHlFI90cgr7r6U6TwVB1h1QjsBJBi1xs04JYRp6b7XKfPTEnJoJUTS18NVJnpx5gc2klv04TWZHGn8dP390PoUg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gqiA/N72k56yx093LXpr69oAYMZeMcg1tJB3FIwjjng=;
 b=uiFLsijt4i6Zl1JQ5M55lXYKhpZMobyR9sbDeHyYGe+Jsbka2wakOKX7M8vQX0FkFGPgZQoWjdJkmReVZencXA31/tzwog341f4T2Pd2z4rsAU/Cq2yHTB0C+0EdGZkZeQejtckrJ2kx+hVRFRmv72uPsP7DvZz+kuLgP6BNshhnJWJetwiQg4E2yUUGEAFBcbzrvM/jy5ybMVhQUMe7x5mN5y6J5sOMeUYR17xiH6AGx4ZBZ55YPZXU8faKn1YALIJf7BD3rkFilEARzySv2SVZKMV2wmbpz7jeA1HI5X36jg//IPnfWiUHaRBbN8sGK3/yVrKwHzCvxjxIKC4QiA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=toshiba.co.jp; dmarc=pass action=none
 header.from=toshiba.co.jp; dkim=pass header.d=toshiba.co.jp; arc=none
From: <nobuhiro1.iwamatsu@toshiba.co.jp>
To: <biju.das.jz@bp.renesas.com>, <pavel@denx.de>
CC: <prabhakar.mahadev-lad.rj@bp.renesas.com>, <cip-dev@lists.cip-project.org>
Subject: RE: [PATCH 6.1.y-cip 0/8] RZ/G2L DU enhancements
Thread-Topic: [PATCH 6.1.y-cip 0/8] RZ/G2L DU enhancements
Thread-Index: AQHb8oFqPZAOpncmd0q5EaH7xMGqn7QyZx/g
Date: Tue, 15 Jul 2025 01:16:29 +0000
X-TSB-HOP2: ON
Message-ID: 
 <TY7PR01MB14818B51927B13AA41CA337899257A@TY7PR01MB14818.jpnprd01.prod.outlook.com>
References: <20250711163222.191633-1-biju.das.jz@bp.renesas.com>
In-Reply-To: <20250711163222.191633-1-biju.das.jz@bp.renesas.com>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=toshiba.co.jp;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TY7PR01MB14818:EE_|TY4PR01MB15953:EE_
x-ms-office365-filtering-correlation-id: 5519cf3d-0605-4482-5134-08ddc33d3a61
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|1800799024|366016|38070700018;
x-microsoft-antispam-message-info: 
 =?iso-2022-jp?B?WUhmbzlKaFVMczBmS2pZQmcwbFE5b2t3YW8zakllVzBBUFlrYTBvRWZ3?=
 =?iso-2022-jp?B?dmZtb2tRT2xkVXdaWXE4bUlZNEF2UDlrdklMNHQzYWViaHg5ZWM4MnFQ?=
 =?iso-2022-jp?B?TVYwSDdUVGRSNXUrUkFaWDFYRk4xY3U3OHNsRStTa1ljK0RGc1dtSHEw?=
 =?iso-2022-jp?B?dVljL0Y5a28rU2xUQkxTdGxZVTEzNmdHWHExanRLY2dHRmR0OExLekE4?=
 =?iso-2022-jp?B?cWVENytNVHR6VHhZTyt0eVhGZUk5bVhRbmtTUitLUmpJMHF4RzZuYnVw?=
 =?iso-2022-jp?B?UTdsOHE3SXo2S2hzTjUzYy9ucTNrTDhieExrWXJGVU82ZVNlV3JmdEJV?=
 =?iso-2022-jp?B?Q0g5S1gwK01zalhKUGcxKy81NWhyc284MlcvZ3JoQ01BY0ZNRzBqdEVZ?=
 =?iso-2022-jp?B?WHlrb0k4SHdxdVRKY09aRlJOQTNXNUJqMlRvMkQ1SXRveENQWEQ4cmlS?=
 =?iso-2022-jp?B?NFY5Y3pJWStkU3FnYmFKem9oWGc3akR2Z084OGdGRmdTZ01BOHpLT0Jm?=
 =?iso-2022-jp?B?WTBOTDlNWk9xQkZYMU0reXplT0N0UVgrTkhSeUZlaU9WNE54Tys1WkVm?=
 =?iso-2022-jp?B?VEVCWDM1d25XQXJaME9zdVRhcVFjMHR3SmJqWVhFMWczaURFcW8zQlNM?=
 =?iso-2022-jp?B?azNWajRtMU1McHYybjg1U0wwZllmdytRTVpEeXdqcnN4RVlXQ1A5RVBO?=
 =?iso-2022-jp?B?SFpuZUZ2YTJoZXZTMEJyWFJOZnpzSVVzNUl4eklxdDBwcDBVM3Zzb3hY?=
 =?iso-2022-jp?B?TjJlWDB1TXNmTTliTUZiZ2h5SGNoczdPRFhmWmNaYmVvNHA4N0graEJ1?=
 =?iso-2022-jp?B?Si9jYlZaL1ZhQjVpU2QvQlhhZlNNOUpPS0p4N2F4QmRhNnZ5VDYybXRs?=
 =?iso-2022-jp?B?YnpTVFJ1TUZjbHBaNWp5TDlvNFVKdG5Lbm1QWXAvOS9Fd014Q1pBU1BI?=
 =?iso-2022-jp?B?N0piZjBMVjJvN2M4ZGZadERKa2NhbGRpUStmcFhtM0tPSEpvQ2ZFTEJ1?=
 =?iso-2022-jp?B?N2VxYWRINUNUR1pzVTB6UEozVU84bzhRM2kwZ1JVcmV1NVk5dVVESklz?=
 =?iso-2022-jp?B?WkxacFkyTXpIUFVYN0k3RUdscmU3dVJZeWdYSXFvU0RCbUlTZjgzWkIx?=
 =?iso-2022-jp?B?ajkvOEEzT3JLWXRFSHdZNDd0RloxY2F1NCs2b3h2S0lWb1J2bUUwZmRI?=
 =?iso-2022-jp?B?TUNLaTR3a29vZDZjUk95T1lLL0NKZEh3Ny90Q2x2TkJBdmZVMmljT05S?=
 =?iso-2022-jp?B?dDYxaGpabHF5eTJNdGJ1TmordlE3OGdJYkNNUDRaa0FnOTNkQkRvdlRt?=
 =?iso-2022-jp?B?Y1BBZkdjUGxMbzhESXBnSk0wK0hvaGVmaTBKajl1TnlqSXkrbVpDdDFx?=
 =?iso-2022-jp?B?M21hWS95azk0RVBSWnJsNmt3c093VGhkSDNhSitTZy9udmJnSDBoMWpj?=
 =?iso-2022-jp?B?OG81ZDRXSUVLamlrZHQzRnN2MWNrelBpOCtnRnFTampPd2V5NE4wbjBa?=
 =?iso-2022-jp?B?SjZ3Z3RtKy96MzZ5a2IyaTZSeXdtaFNhc2EveXk4OSs5RnRRS3VsWE1j?=
 =?iso-2022-jp?B?akdhNkx3dVF6THBidklrZGdhUmc5L3ArcFQyaTV2UEQ1UEcvV1EvMWRE?=
 =?iso-2022-jp?B?V0RFWDlnVi94Z0MvZDN2YkVjNVJBcFk5S0FYRnhQcTdGUzlZQis0QUEv?=
 =?iso-2022-jp?B?V3VGUHBnUDIraHJrVkdkQkhOQUltTy8vTDc5Y0ZmQXRxaGJHOXRRZUlk?=
 =?iso-2022-jp?B?VS9PclptNVpnMjVScGtULy9lRGJpZmdDbnVrWlNQK1MwRHNOK0xTZ29Q?=
 =?iso-2022-jp?B?b3NiR2ZEeTBYaTd1OFIyZWhQRHJtTURjV0lvWjFMQWpHbDNMRWYyTFZR?=
 =?iso-2022-jp?B?TCtIeGNscTYwNlN4MUk0ME14U1k4Tkl0bzUxNmE5WUg3My80a2Z5TlFR?=
 =?iso-2022-jp?B?Z2FQMFR0R3o2QTArbjgycVlzMXlQS2xHZy9RMzRyZ1UzUjM4Z2RxdnNx?=
 =?iso-2022-jp?B?L1RJbmpDU3h1aDNqbXZQSzViQVV4MUFHcHRHT2UvWmdyeC9WOU9PcTBo?=
 =?iso-2022-jp?B?bU5UZlJzNnpyZUlHbGtFMHZiMFF1KzZoK1V0NGcwcWlRUHFFUTljSVRj?=
 =?iso-2022-jp?B?WThXS3plZWJnTUs3RUVqU0NMVjFlUytBPT0=?=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:ja;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY7PR01MB14818.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?iso-2022-jp?B?OVRWdEVyRFVCQ3dPRWxpUW5FOW0zYnAreHk5cjJjUElmV3lMb0pkMW4w?=
 =?iso-2022-jp?B?djQ2dENaQlhubVkzYWp1L0NFaUJNcjU2R1NWdm9iY0ZrNGdZbWJ2bWFM?=
 =?iso-2022-jp?B?RFVCRXZQdXNhNWxKa0h4YzVrYWtqZE9rNUQ1b2dKQU9ZMFA5aWZuSTIz?=
 =?iso-2022-jp?B?M2FRcEV4VmhzZnRJajZiN0tXcEV2bFc5RXFMV2FOMXptdnY0eTZBMW9X?=
 =?iso-2022-jp?B?bHVBTFE4SklkRWp0NDhnRzF1aStzOVF4cVR5TitudFlZcU5LekVzVG50?=
 =?iso-2022-jp?B?eHFUazZkYVJwOC9oTEErS1NtQmFNUmVrc2lYc2NiTjRHN2pVT2lWaWFU?=
 =?iso-2022-jp?B?UmhoUm5NMlg1cTNjNExOS2JVd2xRWStuVW1lbUIrdnYyUmFnOUEzZytD?=
 =?iso-2022-jp?B?VTRHTWNyU2pXTUtMRVByaEUzR1ZtV0ZwN1dxSG9JSm5yMmNtNGxYYzV2?=
 =?iso-2022-jp?B?WjUxOFQySWNWRlVKNDRCcjBERmJlS04xQ2RPKy9pMjByb0c4TjMrVCt4?=
 =?iso-2022-jp?B?NlFzYUNSTXJ6dDlDMFgzRlluak1oc2JLY05uVWN5RGx0bHpKem53M2xJ?=
 =?iso-2022-jp?B?L1M3VC9VSjlraXRqekFzUjNPRDQ5MXgzWFlHMWpncktSSHlJTWlackhu?=
 =?iso-2022-jp?B?Y01JU25Ia09hbFZHNFpwZ3pKT2Nzdjh3cHNURkVVZk9PNDk5cVJIS1FQ?=
 =?iso-2022-jp?B?MEk5MzNZa3Axalh4Kzd0a0tFeGtHak1nNnh1M01Gb01Jc2RoNlh5OU5o?=
 =?iso-2022-jp?B?ejB1RkdWMFlLTitoSWJLejZCSHBaMkxoYW9TTnE2SCtUYll4YzNaTjZD?=
 =?iso-2022-jp?B?K3JoUktQdkltenovLzBvdHFFeHh1cERPZjdZeE5xTnFBMG5ZOVFoc2Zw?=
 =?iso-2022-jp?B?MFhZWGpLMUgyVEJGeWRUeUh0V0VkdjIyR1Q1QmFPcVhiUjBKN0FJWDgw?=
 =?iso-2022-jp?B?VTh4cW9SamtaMVJ4VmJxaWxidkNXaXpSbG5uUTRIdXZTNklGTHJ5UHhx?=
 =?iso-2022-jp?B?YlVEZ01EdE5xRDFIZFQwTGc2ckswQStPeXoxRXloZVFuUlZ4Yi8xMzhp?=
 =?iso-2022-jp?B?SHNZU08xa2dZd08raEhwMFlaYWlzRDdVM1RrWVhpSC9hVlZic1QwTFho?=
 =?iso-2022-jp?B?NXRCdHY2RTVhdlRvSjQ5OE5DVWhLdS9vZHhvNlY3akNHdTFoRERzR0lN?=
 =?iso-2022-jp?B?VzRCeC9HTlhiVGNrWmJVZDVhSmI5d2QrQjNqejBSbUY1Zm1reFR6eStF?=
 =?iso-2022-jp?B?V3NPeExpSmhBdWt0Wi83a2FBbVBvVE9qQlFkMDBsc0lmMW84eFIzTzZI?=
 =?iso-2022-jp?B?Vm85S0tCcHcrcHZEM04vRXhpKzNyUXBzYTVJeVBwb0hLNVZiaUJxRVV5?=
 =?iso-2022-jp?B?SmR4T1plRlo4WVltOUhRTjNRZXZrNTlCQkN2bCtGVDBMTTBubmU4eWtL?=
 =?iso-2022-jp?B?RDJUTUJCVVBGZ2ZyNnJ4dUFBMkpyOXZKZkVTWFcraG5Gelpld052Tncr?=
 =?iso-2022-jp?B?N2llYlBBbUN4SThJNHdWVTRWdUkyOHU2UWtlcTlJR1BndEJUdHRsNTJ5?=
 =?iso-2022-jp?B?bGVJa3dRM1RaUTNNcEQwUWNzOWs4dU5UWDd5VVI2VGRWaWVVNVA4dDll?=
 =?iso-2022-jp?B?QmNRNjNUeUV4aVJwOFFQNDl6T2w4YThFN0RnVGx2cWhobElNanBmZnpx?=
 =?iso-2022-jp?B?WXlZQXJJZEJ3M2VUTkx0N2JFVVNFNWp3dU5Nd1pmYmZCc1ZPb2JrR1BO?=
 =?iso-2022-jp?B?TkM0K3pSWXROZGc0dzlQWStjUUJ3bVJXZ1F6dDlVNzl1NnNhZXEyNnlU?=
 =?iso-2022-jp?B?b2FwTXlNaWRiYlZBTXVyZnp4RmNHTjdmQmE4cXBlbU9Sdkd1RnJsV3ll?=
 =?iso-2022-jp?B?cVpaYkpnUGxzMTZHR01iUFF5WnM1QVVmSkNsNUtzTWs0Z2dncmNUTnh4?=
 =?iso-2022-jp?B?ZGRINUN2ZXY0NUxNd3lKSFRMbUxlYkdDME5YdWcxdUs0YUM0a1p4U1Ax?=
 =?iso-2022-jp?B?Y3htU3NqV2hVQlV1MDVkYjJVNkJ5ODkrYWhUMkRvN0tjbk9ZMmtzOFVH?=
 =?iso-2022-jp?B?d010OGRiTzBpTTg1d1lzTkNhUVlkeG9xd21kd2lyWUVORldvVDVHVzI0?=
 =?iso-2022-jp?B?Y2xyQ1VORXVpWEw4d29NK25yTDd3TlorTDhtQzk3NElUMTNIeVVWSlgx?=
 =?iso-2022-jp?B?UDVySkJGK2xnOE12dTZYRm5hM2REV0RVMUtkaGRLMkdTSmExcmlydzFr?=
 =?iso-2022-jp?B?UjVvYW40d2MvbG1pbW9DbU9hcGtpM2FqaStzMTA4cEIzUkdHQjNOQzcv?=
 =?iso-2022-jp?B?THhhZjJ3anU5cE5zanczNldTOC9zUGloSmc9PQ==?=
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: toshiba.co.jp
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY7PR01MB14818.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5519cf3d-0605-4482-5134-08ddc33d3a61
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Jul 2025 01:16:29.5944
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f109924e-fb71-4ba0-b2cc-65dcdf6fbe4f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: HUo449hLZVYaFEmh54ubMIFAkRuwnmy7BeoN+rbiLPXUN45TO79KPnJcakUYW93vbDc6vTq/LKEkmTlORVYxapsfcuUv8IgdWs33TFUMuxlyCs3Vwe4Bb39STsD4DYzZ
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY4PR01MB15953
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 15 Jul 2025 01:16:50 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/19528

Hi all,

> -----Original Message-----
> From: Biju Das <biju.das.jz@bp.renesas.com>
> Sent: Saturday, July 12, 2025 1:32 AM
> To: Pavel Machek <pavel@denx.de>
> Cc: iwamatsu nobuhiro(=1B$B4d>>=1B(B =1B$B?.MN=1B(B =1B$B""#D#I#T#C!{#C#P=
#T=1B(B)
> <nobuhiro1.iwamatsu@toshiba.co.jp>; Lad Prabhakar
> <prabhakar.mahadev-lad.rj@bp.renesas.com>; Biju Das
> <biju.das.jz@bp.renesas.com>; cip-dev@lists.cip-project.org
> Subject: [PATCH 6.1.y-cip 0/8] RZ/G2L DU enhancements
>=20
> This patch series for enhancing RZ/G2L DU driver.
> All the patches are cherry-picked from mainline.
>=20
> Biju Das (6):
>   drm: renesas: rz-du: Drop DU_MCR0_DPI_OE macro
>   drm: renesas: rz-du: rzg2l_du_encoder: Fix max dot clock for DPI
>   drm: renesas: rz-du: Add Kconfig dependency between RZG2L_DU and
>     RZG2L_MIPI_DSI
>   drm: renesas: rz-du: Drop bpp variable from struct
>     rzg2l_du_format_info
>   drm: renesas: Add zpos, alpha and blend properties to RZ/G2L DU
>   drm: renesas: rz-du: rzg2l_mipi_dsi: Update the comment in
>     rzg2l_mipi_dsi_start_video()
>=20
> Kieran Bingham (1):
>   drm: renesas: Extend RZ/G2L supported KMS formats
>=20
> Laurent Pinchart (1):
>   drm: renesas: rz-du: Support dmabuf import
>=20
>  drivers/gpu/drm/renesas/rz-du/Kconfig         |  15 ++-
>  drivers/gpu/drm/renesas/rz-du/rzg2l_du_crtc.c |   8 +-
>  drivers/gpu/drm/renesas/rz-du/rzg2l_du_drv.c  |   1 +
>  .../gpu/drm/renesas/rz-du/rzg2l_du_encoder.c  |  18 +++
> drivers/gpu/drm/renesas/rz-du/rzg2l_du_kms.c  | 120
> +++++++++++++++++-
>  drivers/gpu/drm/renesas/rz-du/rzg2l_du_kms.h  |   1 -
>  drivers/gpu/drm/renesas/rz-du/rzg2l_du_vsp.c  |   9 ++
>  .../gpu/drm/renesas/rz-du/rzg2l_mipi_dsi.c    |   2 +-
>  8 files changed, 153 insertions(+), 21 deletions(-)
>=20
This patch series has already been applied, but since
I have reviewed it, I am replying for the record.

Reviewed-by: Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>

Best regards,
  Nobuhiro


