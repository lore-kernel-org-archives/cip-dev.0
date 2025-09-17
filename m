Return-Path: <prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76A3DCA0EE8
	for <webhook@archiver.kernel.org>; Wed, 17 Sep 2025 08:26:21 +0000 (UTC)
Received: from JPN01-OS0-obe.outbound.protection.outlook.com (JPN01-OS0-obe.outbound.protection.outlook.com [40.107.113.66])
 by mx.groups.io with SMTP id smtpd.web10.17783.1758097576985074557
 for <cip-dev@lists.cip-project.org>;
 Wed, 17 Sep 2025 01:26:18 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@bp.renesas.com header.s=selector1 header.b=KbSVDRQL;
 spf=pass (domain: bp.renesas.com, ip: 40.107.113.66, mailfrom: prabhakar.mahadev-lad.rj@bp.renesas.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LcoA+FYM61IJAvlmn8sl+bXbVgjsAkuFgTY2YPPOSyIDAZC/MBsK9nl5UhI4jQ/9SpsCc/Xd5O8xuEVz304pnUT+1S8tC6/GpXpI7eD9HkT2poUvHDzCSviTTvvseBNiG/OYZLU9sdZl/koHwmOxn5+v/ACMxdbyVduugB8ILoVGtus4/ytWAkZKALKkaQuzMQpSiYHqEehAb+YZ7SaAORS+4Nkz8YKeAMuFfgft2VjkZtffqH1jwqOYPs8HP/p2ankAiQcYIEBdUp269WAN3VKF1ztyivINLWn/J7EAj9VKUHoVT0kPFPcCMErw7xDO1bjB0rlLc3T2X9hNpMuydg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Mtq6tx3h1Cb1Mx692LW/txFxgiG4h4C8hEAUzydZweE=;
 b=T19PpxvwMdj/j4Be9sXfWwqYCvn5XyYw3EmIloVO82Di9UwWC+ilfYMwO9+e65D1Wd+5jvgxTz/C5zl/XS8qmckfSUovy9SVtliGvTcz9fDFKFsjtRB9BM2E/HRLQjGeyYAdi50kLLrt6QOM5wB5/nnszmlFpfazLg/ZUMEYLIe5wEdQ+3agi3zFSJhiwCjn/q4/azMlJBIKsgPCBhrb/VthajH15E6NKEU6BE6hjeHSO+R6J7hhnD9kUqJrTxhPPKBB5EfE4gUsOxgPxvfLRPXsPzN/axo1BQazqOxekTIpQNVbZa7O/yQNX85eJDlSk4VRialTv8pgmQpsJAc8Og==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Mtq6tx3h1Cb1Mx692LW/txFxgiG4h4C8hEAUzydZweE=;
 b=KbSVDRQLIhBNTxu0ECXYsyXDVVLEKm3hfQrDii8YO82DoiSFltyGlLL6xo1V/7OrbkKaMc4nH0uHJsbf+WR9ouKqqWKveRoHCwTff5DpVRqsMeomQINXuwZJWICZoGXmNFCQEqNgm23b3CKWK3JYekzC5F/CY2Jl8S8dd5EfKck=
Received: from OSZPR01MB7019.jpnprd01.prod.outlook.com (2603:1096:604:13c::8)
 by TY4PR01MB14200.jpnprd01.prod.outlook.com (2603:1096:405:20b::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9137.13; Wed, 17 Sep
 2025 08:26:10 +0000
Received: from OSZPR01MB7019.jpnprd01.prod.outlook.com
 ([fe80::8a27:ee0d:d7a4:9d10]) by OSZPR01MB7019.jpnprd01.prod.outlook.com
 ([fe80::8a27:ee0d:d7a4:9d10%6]) with mapi id 15.20.9137.012; Wed, 17 Sep 2025
 08:26:05 +0000
From: Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>
To: uli <uli@fpond.eu>, "cip-dev@lists.cip-project.org"
	<cip-dev@lists.cip-project.org>, Nobuhiro Iwamatsu
	<nobuhiro1.iwamatsu@toshiba.co.jp>, Pavel Machek <pavel@denx.de>
CC: Biju Das <biju.das.jz@bp.renesas.com>
Subject: RE: [cip-dev] [PATCH RESEND 4.19.y-cip] gpio: rcar: Use raw_spinlock
 to protect register access
Thread-Topic: [cip-dev] [PATCH RESEND 4.19.y-cip] gpio: rcar: Use raw_spinlock
 to protect register access
Thread-Index: AQHcJxsU15XIvqnudkqkJIFsAWppqbSXCtmQ
Date: Wed, 17 Sep 2025 08:26:05 +0000
Message-ID: 
 <OSZPR01MB701922F2413556816B1238EBAA17A@OSZPR01MB7019.jpnprd01.prod.outlook.com>
References: <20250914195415.74725-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <1203971061.247035.1758034994203@webmail.strato.de>
In-Reply-To: <1203971061.247035.1758034994203@webmail.strato.de>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OSZPR01MB7019:EE_|TY4PR01MB14200:EE_
x-ms-office365-filtering-correlation-id: 49e92f15-1297-41f1-645b-08ddf5c3d878
x-ld-processed: 53d82571-da19-47e4-9cb4-625a166a4a2a,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|366016|1800799024|38070700021;
x-microsoft-antispam-message-info: 
 =?utf-8?B?MGsxbSszWlNmRDZYa09IREJQV3lTWTgvak1XbXNDN2JYZ0lOOGZxK2o4Mmxh?=
 =?utf-8?B?M0dHa1Q1T1pRWWk2VFhtV2RXZTJWQ2FQM3dpZUZCVDlCRG1heHBnYSs3M1cr?=
 =?utf-8?B?NE12ZjNjdWFRWEZCb044dkxlbHVPbzE1SzAwdWVCVHhnTXEzemRrNXFTckh4?=
 =?utf-8?B?V2dJQVlJY2lSblBWWlhOWmpQUDRPV2dBaEhCbk0zdG01ODZjbnVJMXY3T3kv?=
 =?utf-8?B?bWkvQUFCRzMyT1F3TzJpbWRveWNwK1ZnRFV2Sk56UHV2bmcvczhYTWF0YjNK?=
 =?utf-8?B?NUNSU1RYU2U3WFJvejR3ZCs4M08yVktkK0tRYmRuaFRBTnJnMkN1Q1plZmtw?=
 =?utf-8?B?RDdxblk5QXBVMnJRcm9hN0JZZThnM2lldldGODVZQXNQTzlzUWNRcURmZmFK?=
 =?utf-8?B?RzNSOWx2OElYRm1sRTFYRUFMUStFTDkrT253REE4RjZCY2hxWjBWT05HTXB2?=
 =?utf-8?B?TFZxZ3V4czd5VVYxZTh3ZkdnOU9aZ0hQRm5QcGxGVEJuUkNjVzlnNUw5bU8y?=
 =?utf-8?B?a2F4aUFPNjlpbzBRKytNNWpWSWxFQ3YrNXJJRXBVV09ySStCUjUxTVgyc0VZ?=
 =?utf-8?B?UzdzTTkxNm1DZlZXczN1K2twWFJvdHU0Nkt2RWF3b2luc0tvUGxhUTdaTTN2?=
 =?utf-8?B?U3Q3Zzc5bUltWFNGR1NqRURKMXUyZzYycC9yUVdYRTNibUYyQXdCYVNuRy9y?=
 =?utf-8?B?SE5ZV2l2U3dEYTd2WTdBSnN1N1BkSmsyY1crRzFXdmhCQlgwWHAxQ2l4NHlo?=
 =?utf-8?B?VzJvYnVyWjc4Vys1enlEa0pZZFpvOFVkdlZ4WTg4c0NDMVQyTVNycUFaS3Bz?=
 =?utf-8?B?REV1NENlWStudGpvRkJBdllVY09qakZQZWZKSGlPalVzUTZ2M2lsRkVqcmVt?=
 =?utf-8?B?TW5rZGN1czU2OGVnTGQ2dVF5RDZBRHRXTFFSbGdUd3YxWDJBVnpqMjdlSlNV?=
 =?utf-8?B?cGFYNDBOWDlGNlR5ZFBHdEdoQVl4NHpOQWY1N2N0VWxkenJkdVE5V0FvdElO?=
 =?utf-8?B?L21MYTZKckFlRjM0VTFTU0dVYnFuUllDa1BVaUtRTURDTkRQWTFTTElac1ZL?=
 =?utf-8?B?QVRkL3pXeWFCSVRZc3JqOGFFRXJwbEg1d1IyblVFMGVvL2c3WVlLVEhvemRx?=
 =?utf-8?B?QVJBTEVtV1hvTkVkbE8vSWFFUWNMRGE5NE9FR2ZuTTNtRit5c05vcW1aYUd5?=
 =?utf-8?B?R2tOUDhnbmUxWEtkTUlCN09sTWU4aGVhakN1dlg0THROZXJ6Z0pMNFZ2d20z?=
 =?utf-8?B?TEx6cXNVNWdYcVJLR2FUa2lvMjZRRStmNEMvTEhEWnRlYmRPeW1MVmk0dldV?=
 =?utf-8?B?eS9IY0p2SDNpVVJXMEJvRHZSOWEvMmt2SHdqQ1Fxb1o1bTAxdlZ3cDI5TVFn?=
 =?utf-8?B?Y25kV0hkd21oK0l1NC9Zd0ZhTnk0RmRyZktHZkZsVTNwYzFVMi9LeUp3MmZq?=
 =?utf-8?B?QXE1dnZYYlE0aUNMRnJLMEt0aG9KNklGSlFVRzNXclVJQlErVHZ0b2JSSERz?=
 =?utf-8?B?dHpnZklEamVIMGk2WWlSTW16Zi9acmxPTTVrVzhmdjcwRlNrVERNY1lLSVc5?=
 =?utf-8?B?NGNmN3JLWFcwdXJsQ3FqdXJrUGphUmtKSHNsUk0vQmZMbG1VNmJyV0Y0ejBl?=
 =?utf-8?B?Z2RDZmIzdXV1Q2NaVUwwekVCdThoUE0vR3dDaUpmMnBrYklXL3A1dlRzbUNy?=
 =?utf-8?B?SVl1U1kzU2tnU0tDSVFQcXVDcExmSnpXUURhMkpQTE95Wm1KdHRTaWNFeW04?=
 =?utf-8?B?OGM0eCthMitYZHZoUjBmTnljZitZTHlQZkRJRFlDNUlpRWVKVzgvMGJBaUQv?=
 =?utf-8?B?a0tmeXhDTXdpZk1UL1ZZdVVSbDBtVUtlWmkxYjlBVndlSEhVdm1OMzJmeWFI?=
 =?utf-8?B?UWdlOHlodE4rbjBxaW5paENkb0xyZTB1K3VHN1RIT1JxdnBuNXl5aHRoemF5?=
 =?utf-8?B?ZTRZYXl4RFZWRTJtTEV1MG9Ecko3NU1qT2lWYng5a3h6K3B3aG5BTkpmWmlp?=
 =?utf-8?B?UTR4WkJVMjZnPT0=?=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OSZPR01MB7019.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?utf-8?B?cU9VN1Ezb3U0ZzFWMFM3OGZRN0V6N3FBWDZqMm5mN1hTUVlqalJHTk4rb0h1?=
 =?utf-8?B?Z3I1K0czSW5iU05tbFQ3bk9FcTE4Mmp6UUZPd0NmWk14SHJBbCtKMzl4MFdw?=
 =?utf-8?B?UUdZQ2FqeDBnKyt1YWl3S211R1VXK3pRZUZwOW1oZXBtY21CMEdDaG14Umk5?=
 =?utf-8?B?alBvVjN6TmZIVU9QVVd0bHpKdm1PbW5ReGhvU1FZS252YnhlUU00WWJHWjhB?=
 =?utf-8?B?TUo4U09TZW04U1ZiTkVLdCtxNFI1RVFXYVBBekU2Q0FqV2V1THFKN3BNb1Bk?=
 =?utf-8?B?WGV1V0ErVjNUKzZoMFMvZ2xCNmtIYU1tclMrdmp1R0YyU2htYS9JMUI2K2Jj?=
 =?utf-8?B?SEFNWUZvS3d6dFdCOHZjVUVQNWFpTDRBNi90a0ZoNjdBUDRXQ0Zob3EwMXdu?=
 =?utf-8?B?VExKTmxSZUYzQm1Bd1lIVWFjWTRObUE0ZjViWUVXWXNhbFdFcEJKaHRFOHNo?=
 =?utf-8?B?Uk1hbG9YbGEybUVUZ0dxTGhITDc3V05FeFpkaXVXWWx1dnQxd2V3TmQ2QjV4?=
 =?utf-8?B?QUJneXVteU9EZ0NXZk1HYTQ2a25lN3gzdGxvb3Q4TkF3UUdvTlZuUTQ5Y1dT?=
 =?utf-8?B?VUdVUTVxZ3BZVEN1eEN4WVFJVXJZTE0yUlp0REVBUlZhdHdWNWhJcWcyVmMz?=
 =?utf-8?B?c2xzWWNnK1hhMnR5TmZic0U3eUdXT3ZLaXIxU1FnZVcybHN6NVVLbXA2MmNi?=
 =?utf-8?B?Mi9LT0wyeWFNaTdDSTEzbFRqbVUvZUpkdkVHVjR6dXZTZ2hQelEvMkdmSktO?=
 =?utf-8?B?WmllTThtS3hJd3crUDlnZ2YwSG9weHhtVTJ1QTZJWjlmMEViU0hqY1lTdXRu?=
 =?utf-8?B?b3FGd0xrU1NlK09NVmN0Yk1uWkZOUHJORll5cjIyR1pVM1B3WGhyclRGWXdZ?=
 =?utf-8?B?alZGTVJpOVR2ZVRZNmZwK0JzS25GMUdCWnRIVFZ5ZFpDVnV3UHMyUFBtZG5C?=
 =?utf-8?B?d0JtYWF6NHdHRjd0a1RWS3lVc3JncnNkaWtuT0ZKOHNYZktXNktmRE9ZR2gv?=
 =?utf-8?B?NlRLSjVKY0kyR1pDaHpZcUhTWDVvZjhQb2hGMFRlbzRMdVRCUzY1SkdhR3hz?=
 =?utf-8?B?VmxIYjAvMEdVcWlRRjBKRFMxaHh3cktkYkdoUm5mblVQZGhhOUJXV2hJU29D?=
 =?utf-8?B?ZlhydGw3akF4K0dBYTkzMlRFQkVJdFhobVJ3RDBOaWpVcGdERlV6cjd4MElV?=
 =?utf-8?B?NmdZNlhiVituNW9NQ3VuZ2hGQkdJVnNYNW92RTFSaWZBLzhMaVRKY1BCcGhN?=
 =?utf-8?B?VDEycWdnd0tnZVkzeFVqU1Blb2JmTzRvR2VkYmU1NFM0V3R6SkZMZjA2aU45?=
 =?utf-8?B?elp0a0NuMFozUU96R0lQYmhNcFdEZFFZSkFEWGxiUlhKYlNETDFKRlhOc29O?=
 =?utf-8?B?SDlhWE5qZDV3Y3hsVFk4YTJ5b3VZZWRmdFhzNmF4SVlmYmJjTXcvQ3E1NHBM?=
 =?utf-8?B?V0dlUmVqRWlFQ21lb0lucnU0cm81WmVWYXVXZkNUbHRTY3BYenFpTmVyZXEz?=
 =?utf-8?B?bkQ3eWJjZHFQV1Fxc3U4MlBNT3FPYVVsUlJCUW1vZDBDdlVFWngrTVkvTXVQ?=
 =?utf-8?B?K09vWmhpV3E0WHNYTWh1dXg3TU85T3piTFR5bzdUeTloNkhNbmZVaWxwV2d6?=
 =?utf-8?B?d1E4QkQrblVuNXdNV3hSNEJEdWRFcStlQVB3eUhwMW9qUkJQaW9QZWd3Z2hs?=
 =?utf-8?B?VDJNTGw2c1hWNTh1dGV6ekJQQlhXQ2JhU0hVa0dmRFRycEJJTUs3S3dmVVJi?=
 =?utf-8?B?c25BdmlZMkV1NkwzR3FrRVpzTEFkVWJBdFhiUmtRek41Titxemd2cjE2aklL?=
 =?utf-8?B?N0tuSjhaK3ZhZ3RjQlZ2d3Z3S3FIQ1g1ZUJzM1lxKzMwbXR0RWZpT3JIcGxN?=
 =?utf-8?B?S1YrMHlGM1FWTys4aFFFSlZXejc5enRCcCtBWUtvMU1taFUzWGJCcFpsZEdZ?=
 =?utf-8?B?d0RhMDlDZkRTcUhNOGRMRWx4SXgvZGZDSVJUWllZQm1SS0RxRzArM2dEalVs?=
 =?utf-8?B?SllsaGNIYlh5TlJmTWp3WDluR0FrMTZEVHBnUU8wQXY4Z201ZVBMNUVPT3lF?=
 =?utf-8?B?M2xlZk40TnFPMzFWclF5UEsrTjRGV0Qvb2pkamFoMlc1bWE5R2JBOVFRNC9P?=
 =?utf-8?B?MGF2RHBRU1l0LzdhOXBTRUEvdEM5ZWxUT3pPUDQxaDhQL3dVRVVaWStMQlNU?=
 =?utf-8?Q?jwkMTV7np1Emnvngb6eCevc=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OSZPR01MB7019.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 49e92f15-1297-41f1-645b-08ddf5c3d878
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Sep 2025 08:26:05.5415
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: N6FZn0OpSIR0B9RF69J1INqKcSVWzSk6FdWhalY/ul+pxPqJf/9sQzRJBQbZqaSCF49DokgPJQ13plXO2VAUSernNEgJfH+l1h+5A0JT3Mu0qMPe/K1cKwF6tIdUfUaz
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY4PR01MB14200
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 17 Sep 2025 08:26:21 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/20070

SGkgVWxyaWNoLA0KDQo+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+IEZyb206IGNpcC1k
ZXZAbGlzdHMuY2lwLXByb2plY3Qub3JnIDxjaXAtZGV2QGxpc3RzLmNpcC1wcm9qZWN0Lm9yZz4g
T24NCj4gQmVoYWxmIE9mIFVscmljaCBIZWNodCB2aWEgbGlzdHMuY2lwLXByb2plY3Qub3JnDQo+
IFNlbnQ6IDE2IFNlcHRlbWJlciAyMDI1IDE2OjAzDQo+IFRvOiBQcmFiaGFrYXIgTWFoYWRldiBM
YWQgPHByYWJoYWthci5tYWhhZGV2LWxhZC5yakBicC5yZW5lc2FzLmNvbT47IGNpcC0NCj4gZGV2
QGxpc3RzLmNpcC1wcm9qZWN0Lm9yZzsgTm9idWhpcm8gSXdhbWF0c3UNCj4gPG5vYnVoaXJvMS5p
d2FtYXRzdUB0b3NoaWJhLmNvLmpwPjsgUGF2ZWwgTWFjaGVrIDxwYXZlbEBkZW54LmRlPg0KPiBD
YzogQmlqdSBEYXMgPGJpanUuZGFzLmp6QGJwLnJlbmVzYXMuY29tPg0KPiBTdWJqZWN0OiBSZTog
W2NpcC1kZXZdIFtQQVRDSCBSRVNFTkQgNC4xOS55LWNpcF0gZ3BpbzogcmNhcjogVXNlDQo+IHJh
d19zcGlubG9jayB0byBwcm90ZWN0IHJlZ2lzdGVyIGFjY2Vzcw0KPiANCj4gSSBtaWdodCBoYXZl
IGZvcmdvdHRlbiB0byBtZW50aW9uIHRoYXQsIGJ1dCB0aGUgcGF0Y2ggaGFzIGJlZW4gcXVldWVk
IGZvcg0KPiB0aGUgbmV4dCA0LjE5LWNpcCBhbHJlYWR5IChpdCBkb2Vzbid0IGFwcGx5IHRvIDQu
MTktc3QpLiBVbmxpa2UgdGhlIG90aGVyDQo+IG9uZSwgeW91IGNhbid0IHNlZSBpdCBiZWNhdXNl
IHdlIGRvbid0IGhhdmUgYSBsaW51eC00LjE5LWNpcC1yYyBkdWUgdG8gdGhlDQo+IGxvdyBpbmNv
bWluZyBwYXRjaCByYXRlIGZvciBDSVAga2VybmVscy4NCj4gDQpUaGFuayB5b3UgZm9yIHBvaW50
aW5nIHRoYXQgb3V0LiBTb3JyeSBmb3IgdGhlIG5vaXNlIQ0KDQpDaGVlcnMsDQpQcmFiaGFrYXIN
Cg0K

