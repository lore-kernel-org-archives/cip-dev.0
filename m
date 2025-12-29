Return-Path: <ovidiu.panait.rb@renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 008DFE8FDB1
	for <webhook@archiver.kernel.org>; Mon, 29 Dec 2025 08:52:20 +0000 (UTC)
Received: from TYVP286CU001.outbound.protection.outlook.com (TYVP286CU001.outbound.protection.outlook.com [52.101.125.24])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.40227.1766998337382366955
 for <cip-dev@lists.cip-project.org>;
 Mon, 29 Dec 2025 00:52:18 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@renesas.com header.s=selector1 header.b=VHGaDQwN;
 spf=pass (domain: renesas.com, ip: 52.101.125.24, mailfrom: ovidiu.panait.rb@renesas.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Y7gCOoSsPvcjHyFKgtCoDbiKLUy8cpxZ67WQ3g9M33bdcks+4oll3ztsdISf215SALqyKH3xXLupQiGyoXnIvmwsv+ZlwnVtGcM+hEE35yQ3Qwlrl3n72xQ0S9dSl7il5U7Q2Vz4uiNXaJUWmXDwOu8nvwnKQTKlCtZ660h1WfU2z2N9726l8/snNdLIjl69I1t0HDi6ERbhNpYfiruV0DiV4WR8cVYrtnQWaaCq0DLE9maBgiMZ2rRwMC3thbF/Q5hA6ld9gik4ezsFbR8Jb2CaZfeegQl++2VDIMd/lVpuHs1SzF4pRZvz0oxvhK0ipnF1YXZiA6f0Sc53mnnyQQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9TGrUA/sspzK1vUZqkVt7vaGT0BPxA/GryjXApzDdE4=;
 b=FHmIa8BEA7NbECP7FAG2OH2vswS+Fs5EHdZGL4AYv79iNXbG1+8yXc4z8F3VNoqsRrnu/vCOAWlxg3xYkURE8KKBr+//pq4ij+DrcRAO8t1Kp+qP8SRe6SLNkZzO4xhbBM7Qt9X9De1Bu7RXaWO/9J8d2du180XHnlg2VnZ0l7nRryC/W22MJ8xLNX5S5BmdIerjZCICT5Nm8b/rSdkdPTHShvVh0fkNs5+12ojxSf6p8me4SL3V4Q0rHMKZCe+IW+Xak+FcWhGoJSCfmuR+5R2i13UggQpcBgbSI4Y99Ztlk6mTIkbipZKA/iNjj1UniwLCcLslTLyNExmUsdygJQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=renesas.com; dmarc=pass action=none header.from=renesas.com;
 dkim=pass header.d=renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9TGrUA/sspzK1vUZqkVt7vaGT0BPxA/GryjXApzDdE4=;
 b=VHGaDQwNSx+VjSqNAmpZTno75I2xMsGvWWJPFUFIACSDy366tSLGrhiBPKWi+EdQnAmlMJwXlDfhNb5r1CFzOnu0J0wgqrtyucJ4/wqqC/D+dULaw/saA5cj1KwiTVAUO48zCaELA7hR1cb/bFaqlcHAQxNtUT1SEjvckqqRA1Y=
Received: from TYWPR01MB9277.jpnprd01.prod.outlook.com (2603:1096:400:1a1::12)
 by TYRPR01MB14082.jpnprd01.prod.outlook.com (2603:1096:405:222::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9478.4; Mon, 29 Dec
 2025 08:52:12 +0000
Received: from TYWPR01MB9277.jpnprd01.prod.outlook.com
 ([fe80::b8bf:9f91:41af:6596]) by TYWPR01MB9277.jpnprd01.prod.outlook.com
 ([fe80::b8bf:9f91:41af:6596%7]) with mapi id 15.20.9478.004; Mon, 29 Dec 2025
 08:52:08 +0000
From: Ovidiu Panait <ovidiu.panait.rb@renesas.com>
To: "nobuhiro.iwamatsu.x90@mail.toshiba" <nobuhiro.iwamatsu.x90@mail.toshiba>,
	"cip-dev@lists.cip-project.org" <cip-dev@lists.cip-project.org>,
	"pavel@denx.de" <pavel@denx.de>
Subject: RE: [PATCH 6.12.y-cip 0/4] Add RZ/V2N WDT support
Thread-Topic: [PATCH 6.12.y-cip 0/4] Add RZ/V2N WDT support
Thread-Index: AQHca6+901AOmKmFuk2g14dCjt2QIrUxovtAgAbEfsA=
Date: Mon, 29 Dec 2025 08:52:08 +0000
Message-ID: 
 <TYWPR01MB9277158B5CFE55D2B24CF0F8D3BFA@TYWPR01MB9277.jpnprd01.prod.outlook.com>
References: <20251212213843.24018-1-ovidiu.panait.rb@renesas.com>
 <TY7PR01MB14818E30D0E0BED5C4B7E5D04CDB3A@TY7PR01MB14818.jpnprd01.prod.outlook.com>
In-Reply-To: 
 <TY7PR01MB14818E30D0E0BED5C4B7E5D04CDB3A@TY7PR01MB14818.jpnprd01.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYWPR01MB9277:EE_|TYRPR01MB14082:EE_
x-ms-office365-filtering-correlation-id: 47f78991-2af7-4ed2-c2d7-08de46b78c6e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|376014|1800799024|38070700021;
x-microsoft-antispam-message-info: 
 =?iso-2022-jp?B?NWI3dENBZ3VSc3R4TlBwenhQVk9XV1lHNDNDTktpM1RSdmpCN3JYYzNB?=
 =?iso-2022-jp?B?ZjRLMXpINTVZT3cyOVlLbHFxZlBqNkxjUFdObFFCVGtCenFqUVhGUTJa?=
 =?iso-2022-jp?B?bkpDVmw0U21XbWdiZEVESVhXMmNxeDU3MkREZGFKbWV0bTd0YTdZVTBz?=
 =?iso-2022-jp?B?dzhSOG05akh3aVhqejZnbUVpQ01yQTlFbTl2ZVcvc21oS2VJMTF2cjc1?=
 =?iso-2022-jp?B?bVZqWGFMdFVOaWQ1OGlOZm5kK29ZTU9VYkFoeG5wa0hxTjNLbGlya294?=
 =?iso-2022-jp?B?ZW9sTUExTDYvR2haLytxTjIwc08ySzczbW5OQnluNjlBOEc3MjFtdjF0?=
 =?iso-2022-jp?B?SGRWMFdaT3V1MU1uZnRvOGZTcUppaDNTU1dmRE4vMkphSlZSclFEeXdn?=
 =?iso-2022-jp?B?eDk1MjBubXIvV2MrY05xRThJanlxbXd2ampuUUljcW05WDFkY1pLbG9B?=
 =?iso-2022-jp?B?bnBKYmZxTis0YXk1RVhhSGNtMVV4UVN2Y2VESkkzT2F0dVU2YlVxNkds?=
 =?iso-2022-jp?B?STl0eDN0ODFoMXpHOCswbUNyYjZZNlNtSmt3SHpxaVhJNWEwblY1Szdw?=
 =?iso-2022-jp?B?cTBKZ2FuMndCajg0LzY2KzVzbTAvYXp2dlVSMFFGSDRPdGVvMkpYWVZs?=
 =?iso-2022-jp?B?WjJkZE01SGJLMUdGclExR1MwVEV6elZQSmVTNksrQ1pSNTFQdnBXMWtQ?=
 =?iso-2022-jp?B?MzllWGhyNWxYSXNwbjI4SFdpeE5YUmEzQzNvM1l6OTJNZVMvRzd4RWlv?=
 =?iso-2022-jp?B?Njl2KzIwSUVFbUNMOXhnWkE2SGRRMHJyU2R3c2ljUjN5c3BHSEQrdHUz?=
 =?iso-2022-jp?B?dlJ5QTJ3ak5kRUdXTzB1RFBwSmtYUCttY0RtWkdJdjkrMDZqZEhySC9J?=
 =?iso-2022-jp?B?Q1UrVEpVUmpOd2dFZ0RvOENPSjFRdlY2VW5WaTVkd1ZuamJDS3VTMVFO?=
 =?iso-2022-jp?B?NDdUZE5pdWU4STlGRVoxZjhxaE1kM1ZYVm8yY1MvSG92TDhnTGp6YmtC?=
 =?iso-2022-jp?B?M3FiQW1lc2g3bDR1cGVOV2ttUkFYMWZ5bStUS0c5Y3NtcEhOcStZbUww?=
 =?iso-2022-jp?B?MGpwS0ppalVubXo0M2Rwa1NtanRvVDR2dVUxQy9MK1pJMzBDKzNsUU4r?=
 =?iso-2022-jp?B?aTQ4Sm5vQmJZaGU2KzVwYmJ3M04wcERoM2k0VnNNdU1qUzFtZG40RlFh?=
 =?iso-2022-jp?B?NUdEZ0ZPMXRURGFnK05sa2FCRnR0bWhiSmtZSGNZMFVUUzVRMzhvNDhW?=
 =?iso-2022-jp?B?SDJnU1JGTy9HRTBLWnoydXdEVHBBRHZQRmY2cVpuem9mZ3dsZUFwMzV0?=
 =?iso-2022-jp?B?VjN3eG8vTWRaWUR2Zk1IRmVnR1AwSUNPTlZaQ1ZGSTg1c3gwbnhwaWVi?=
 =?iso-2022-jp?B?Z01lWkV0UEQwMks1OTlNOVk3NlpYMVkzZUdiRlVYaVpUbmZTb25yd1J1?=
 =?iso-2022-jp?B?ZzdCckxDTkQvSmdBSEZDb3EraGxDdHE5YS9DQ1FmWXRJa2tjQzh2bXoz?=
 =?iso-2022-jp?B?RHRtVEQzL013aHQwY3JFeDdpa2lXVW12STVnRk94VGRMZzk3Uks5Wm1p?=
 =?iso-2022-jp?B?RVZZVERYZXQ3K0FSRVkzdE5XV3UyYkNxRXppNUhRanVCSEtWMjFGL1kr?=
 =?iso-2022-jp?B?a3hXWkkyUEpFMENGNjczcGlRcDdmdkVRbUJBRnhtNzRyNFRrSmNaWjgr?=
 =?iso-2022-jp?B?dXZ5Y1N1TEd6czBMSEY4STEzOWZsWXJhSTRMSXNrVmI0NWVxNHgwVDV3?=
 =?iso-2022-jp?B?YU9oazc5NmJNaGdXR0xVZ1FSN05uYVovRm9yZCtmU2pZYWhwaWlpV0Zs?=
 =?iso-2022-jp?B?WlVXMTBkUk5GMlhFemRJb1diQXp1eXZvUDdONUhtVEV4bmpxNy9LM3dv?=
 =?iso-2022-jp?B?NkxWK21FN0dWcDRqQzREMzA3TlNqUnBjcVVUWTE3WUpsQnRWV1ZGOW10?=
 =?iso-2022-jp?B?N1d5UGs4WXNoTldpU2pxU1F0U0Z0TERna2RlQlliUGJGZG9Hc0FrN2xa?=
 =?iso-2022-jp?B?UG1CenNLQVFSSGZTNkE3M0Q3QWxTNzVQWm9SN2xxRENLSGlBTHhxWXQ0?=
 =?iso-2022-jp?B?Si94L0czeUNHeTk2ZXc4TG5ocFd2S2YvTzBFMDdOR0ZOQUFZNDBqM282?=
 =?iso-2022-jp?B?RDFocGcxMERMNnMzQWQwTnBWTUYwOFgyYk5BaTFpRGxXTnFMSG9jSGRI?=
 =?iso-2022-jp?B?bmVNeXBRSUIrVjh1NHFHeFlPZnhQU09r?=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:ja;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYWPR01MB9277.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?iso-2022-jp?B?ZGQ4bDlvcFpWaVhERFo5ZE1qSU56dm5IWlBvREdycXlOWVJ1anhBdzI4?=
 =?iso-2022-jp?B?enBtTzEwbW9NRG90VWRkN2RCb2dDbmU3akwyd2lTdzVoc0M1RlpTM2Nv?=
 =?iso-2022-jp?B?Nkx5T2dZMXgzaWZXaVBubzJGa3BQOE9xd1lRVGxWQXhwMmx1RVpyblRX?=
 =?iso-2022-jp?B?aGtzaXQ2RGRFdC9lYzBrSlVYZkpjYkdlL281cEpFSXI0UzRFa0tnR2Jp?=
 =?iso-2022-jp?B?ejQwbllFT3c3cUR0bXpUbVRJZWVvVFZ0bUdEamwzdWtaN1B6U2d5Y3hZ?=
 =?iso-2022-jp?B?c0VQR0UxcDNKcFl0OWFoYncrQ3hFZEZjLy9KajRvOHhaWXlUaHR2blRr?=
 =?iso-2022-jp?B?N3Rvb3BBSDFLNjlKcTVXSjZNWVoyNUNUNGkxNWZQRmdIUUZ5Q2x5ODkr?=
 =?iso-2022-jp?B?VVBicVlaOG1HcEtITWRieXdidUhXSlBJb2xONzZjNGc3VVBSV3FNcW9M?=
 =?iso-2022-jp?B?TnY4SkhocXJpVFp0SUJ5VVFOWGpzVnFzOGVvbDUxVlJyMUlGWFFJczBY?=
 =?iso-2022-jp?B?VHZtenpjc0U0cjlGUFZvSWJFaVJSSk9wWGtoZE8vdXUvSjhjRTJrcVdI?=
 =?iso-2022-jp?B?ckhFT2k5ZXY5SUdvR2hqRVlSK2ZsNU0xN0NXaGI4MkFXTi9ObmE0dkdv?=
 =?iso-2022-jp?B?SlVjTWxrajE4Zzk5aFdPUU5uNVRMK3hXdFZZcXVaWkhJT25QcXVyVHlq?=
 =?iso-2022-jp?B?WCsySUdwZWZzZjh4QjdldURtSjEveFpNWGFNSGhiZlpsSFJnK1QrM00v?=
 =?iso-2022-jp?B?UDMvYlFXWVpzRXRIK1JHeGdPU1pZWUE0ZG85T1IyNHlZYzdWMlFtcU55?=
 =?iso-2022-jp?B?cmlhbXFJZVZ5ZDB6Z2YzK25MNis5THdvak9pby9RKzhQZ2pXaWVVYzR0?=
 =?iso-2022-jp?B?OXpGam1kOFNUeHFMSm1xMWx5UWs0WXpmd0xLNE5FOGF6WjhJelkreGlq?=
 =?iso-2022-jp?B?YzFYdGV6UGkvVWpsNGpncENnU3ZhMzFMVDJTTnMyaVRBaHVzRXBsYXA1?=
 =?iso-2022-jp?B?Y0JWU0l4MFZoRHhxM1B1NlNrUzFnNTc4TnhxZUZBL3M5VWMvU2xPVlZs?=
 =?iso-2022-jp?B?bGpaSVVIRTVxUUhFeXd5Q3RnMUNsK0x5SnRlWVFzbjdJWVRYY3MwTHla?=
 =?iso-2022-jp?B?L0ZRZnFzZnRVbDh0VUdBN2xCZUd0cUt3M1I1eDNnNDJOMEtCdXRoT0ZZ?=
 =?iso-2022-jp?B?SGJiM1ZhQWUxOFJpcnBpSGVoZWU0ZUtyRDZlemprRzdQNDR3Q1A0S21s?=
 =?iso-2022-jp?B?TlFWS2dVVG9BUXFyM0hyVUllQ1hsTkYyUXg3N0cxTzV4NDZpR1djZitQ?=
 =?iso-2022-jp?B?MkwrQWZ0V29ZTjlLUjdrOFZMNzI0VXNOM2dxL1RTNXJNcTA5b09vTVRz?=
 =?iso-2022-jp?B?RFlVMEpDVmhIcE4wd2poU1E5WWR5NlQyRWZqL29jOWVLbEJNeWZYVWtm?=
 =?iso-2022-jp?B?S2lHSmVrYzl5RUtQYnlsWkd5N3BEcmJKb2FiTWhLQWpveXFhRVhhOUQr?=
 =?iso-2022-jp?B?V3g0OGhqNXN6RzFUMTM3dFVPSi9VY1l0NC9EUGduTnNITmxwRHd6ay83?=
 =?iso-2022-jp?B?SEVmd1VBOE1zQWdNWWxMd2dsYVlsRWpBcjluNzJyNUYxbXMvNkU0S2VJ?=
 =?iso-2022-jp?B?VjRGR2FSSFNjUDU2OHpZVjdraW5XRHArRWM4YVA2dGhwVVVtRXJ1M3Yz?=
 =?iso-2022-jp?B?SXJTVFBIdHRDWmZZWmJ3TFB1bUZ2KzNvYVgyRmpuS2pjdkwwSGw3elZ4?=
 =?iso-2022-jp?B?N3Q4QkREdk5ObnppelBOdDJnKzRHRzIyZW1ScGRQRnpFUkpVR2ZjNmow?=
 =?iso-2022-jp?B?Mk1hWHhsOTE0V1J0MjV0WHpWWTMxaWRCOXVtYVNKSzBROWdOWWpNbUlG?=
 =?iso-2022-jp?B?VkN3aGtvbEF5dUpCNVgyM2hITFFnTGtpd0RtRzRQaTN1UVFBdjZuZVFF?=
 =?iso-2022-jp?B?dS9kWm43NVhud1FHNkg3SWs1dTZ3cUhtbTE3ZWN1b2xGS21RcUtCbHdo?=
 =?iso-2022-jp?B?cm1KU0R0dzRWejNhUmJQOTRVR2ZGY2RBWlg5QVZQeGQ5TGFZL2VtR21V?=
 =?iso-2022-jp?B?QnpDemhkRnBsUDFtb3IzSkxibzdlNFIzcEF5ZG1adjJlTVkvOXlLNEk2?=
 =?iso-2022-jp?B?Z3ptait1QkN0NjlCQ0hHY1h6MHczaThqaUREcXdVUG1BdzZDOVdwdnBS?=
 =?iso-2022-jp?B?UWR2UCtPdVBTcEtkcWpLT2NxOGU4a2FWNVJ5akR5eG9JSDV4QXFEenl3?=
 =?iso-2022-jp?B?SEYyWWRBaGs1RzFxczgwZXkwQmJMUHdqdy9NKzFiRDNteFk1cUp4bXdx?=
 =?iso-2022-jp?B?SjcreE1HMUk4eENiSVpmMEUvU3Y5WDVIcGJNTnJ3SWZEV1VwVXZEODBp?=
 =?iso-2022-jp?B?TlJEcmFYWVRlRzN4MEhTSHNVSlR1WHRMWnF5ODJLVmdIVStadFE5UzdU?=
 =?iso-2022-jp?B?ZGkvRXhaMlkyUEJGV0ZkYUoxT2VjT2o0YmxCbjIyeVJNbGIwSm9aYStJ?=
 =?iso-2022-jp?B?S3lmWkJrWlNOSmJvTmZXeWJYbDRLYVdQMTdNRkh5UlNHY2QvUlplZnF4?=
 =?iso-2022-jp?B?S2RVVjlIZz0=?=
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYWPR01MB9277.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 47f78991-2af7-4ed2-c2d7-08de46b78c6e
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Dec 2025 08:52:08.1827
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 1QjOJZfxoq4ReE2//X0MexHnkrpPLhPs3bPAHUpWTXTtQSUbdrjerho58avo/oACxAawfgj5lnILfxia2KnW8l7I9/komf1PFIaYFVt7gPc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYRPR01MB14082
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 29 Dec 2025 08:52:20 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/21248

Hi Nobuhiro-San,

> Hi Ovidiu,
>=20
> Could you rebase to HEAD of each branches (6.1.y-cip and 6.12.y-cip), and
> resend ?
> I can not apply to each HEAD.
>=20

Thanks for the heads up! It seems the WDT series were applied already to bo=
th
6.1-cip and 6.12-cip by Pavel, so no further action is needed.

Thanks!
Ovidiu


> Best regards,
>   Nobuhiro
>=20
> > -----Original Message-----
> > From: Ovidiu Panait <ovidiu.panait.rb@renesas.com>
> > Sent: Saturday, December 13, 2025 6:39 AM
> > To: cip-dev@lists.cip-project.org; pavel@denx.de; iwamatsu nobuhiro(=1B=
$B4d>>=1B(B
> =1B$B?.MN=1B(B
> > =1B$B""#D#I#T#C!{#C#P#T=1B(B) <nobuhiro.iwamatsu.x90@mail.toshiba>
> > Subject: [PATCH 6.12.y-cip 0/4] Add RZ/V2N WDT support
> >
> > Hi,
> >
> > This series adds watchdog timer support for the Renesas RZ/V2N SoC.
> >
> > Patches were cherry-picked from mainline kernel.
> >
> > Best regards,
> > Ovidiu
> >
> > Lad Prabhakar (4):
> >   dt-bindings: watchdog: renesas,wdt: Document RZ/V2N (R9A09G056)
> >     support
> >   clk: renesas: r9a09g056: Add clock and reset entries for WDT
> >     controllers
> >   arm64: dts: renesas: r9a09g056: Add WDT0-WDT3 nodes
> >   arm64: dts: renesas: r9a09g056n48-rzv2n-evk: Enable WDT1
> >
> >  .../bindings/watchdog/renesas,wdt.yaml        |  4 +-
> >  arch/arm64/boot/dts/renesas/r9a09g056.dtsi    | 40
> > +++++++++++++++++++
> >  .../dts/renesas/r9a09g056n48-rzv2n-evk.dts    |  4 ++
> >  drivers/clk/renesas/r9a09g056-cpg.c           | 20 ++++++++++
> >  4 files changed, 67 insertions(+), 1 deletion(-)
> >
> > --
> > 2.51.0
>=20


