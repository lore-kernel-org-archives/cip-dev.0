Return-Path: <dinesh.kumar@toshiba-tsip.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC817CCF9EB
	for <webhook@archiver.kernel.org>; Wed, 29 Oct 2025 10:02:16 +0000 (UTC)
Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.135])
 by mx.groups.io with SMTP id smtpd.web01.3241.1761732128898768220
 for <cip-dev@lists.cip-project.org>;
 Wed, 29 Oct 2025 03:02:09 -0700
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: toshiba-tsip.com, ip: 210.130.202.135, mailfrom: dinesh.kumar@toshiba-tsip.com)
Received: by mo-csw.securemx.jp (mx-mo-csw1801) id 59TA262h059979; Wed, 29 Oct 2025 19:02:07 +0900
X-Iguazu-Qid: 2yAbDoX6mRXNEIx4sL
X-Iguazu-QSIG: v=2; s=0; t=1761732126; q=2yAbDoX6mRXNEIx4sL; m=fvQJTMPi5iXffYYrc8kq2A6CIBIeqS/Ix8CSxPHEFts=
Received: from imx2-a.toshiba.co.jp (imx2-a.toshiba.co.jp [106.186.93.35])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	 id 4cxN7y246lz1xnc; Wed, 29 Oct 2025 19:02:05 +0900 (JST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=de/iMMm+skTV8HnFfH4zBfTf+AD+Bynix4cO1mKbp6++zhlxlqJTqXV8wTI+ZF8burzozpX7j2SdkECtoLaSrrMKY7h6h5f57WnH6h/Diq5DvEqId9aADnC7Qmo9PO1XN6UFDMXOj2fA76Ls8BtTN53ZTGG+GQ6Z3Zz+yHlz/UaCnbTASJlsj00O4GcyATDYPf3phkpUmxHkNxPoYlQEISdyw0T7np/w8gHGvKG3jI9Shk0G53950dB/KPIYUnwF49AAeElWDjt/oaZPyAxsPU5UK92vYR4mdyu/2GB5JVZIE/gxZnEZqa5nT/Lg61NGNmkntsAN0XPBdXfiDJ19GQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=csR3+dE6PrK/8Z/dvneMyEP8yEFrLlf+k2JZp+I0+3E=;
 b=ZCXr0R3QTceTqr0wx0/aVsEvYkWrpCK0ghHzIy9iKFzgDVSMH2wVK6kMxHdk4xCXuDXS3rnLFZQv9iqVrSZBu/I33TthcEtImV/c/kbctERQ3jjPkZyO4aFnZZVYPJ5449H0KYu0OGfJ5Ysc8P6Ff2V9Jf8TO8vLPtk1oHdVfL8keKWnJ7JodXLYDOdOX2gkqzgaEODa9kbbHh2ncQ22x+EfV1OoJrEGkugx+F4VneHzjYpouDBqU+/UhQVWEuVJE19qQSe5vcH20HkhfQ+1a/QpFVDJ6KAytOd99B0tvuf18nbTi9iHmh5uyVLlot6BDH44bhZGEw1F1CtwQaz39g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=toshiba-tsip.com; dmarc=pass action=none
 header.from=toshiba-tsip.com; dkim=pass header.d=toshiba-tsip.com; arc=none
From: <dinesh.kumar@toshiba-tsip.com>
To: <jan.kiszka@siemens.com>
CC: <cip-dev@lists.cip-project.org>, <hirotaka.motai@miraclelinux.com>,
        <kazuhiro.hayashi.f74@mail.toshiba>, <pasquale.nieddu@siemens.com>
Subject: RE: [cip-dev] isar-cip-core: Shifting defaults to trixie?
Thread-Topic: [cip-dev] isar-cip-core: Shifting defaults to trixie?
Thread-Index: AQHcSCSlRPbY/m07hkmeACGdhPyNKbTY1f0ggAAK4YCAAAOlUA==
Date: Wed, 29 Oct 2025 10:02:02 +0000
X-TSB-HOP2: ON
Message-ID: 
 <TYWPR01MB851096D4D99B298C3969A2FCBFFAA@TYWPR01MB8510.jpnprd01.prod.outlook.com>
References: <87286d13-6e1e-4cbb-ab14-a8af38037b8a@siemens.com>
 <OSZPR01MB8515ECCFEF6C63E9F77F7998BFFAA@OSZPR01MB8515.jpnprd01.prod.outlook.com>
 <4cb2fe94-589c-47c2-92af-ed694cdecf7e@siemens.com>
In-Reply-To: <4cb2fe94-589c-47c2-92af-ed694cdecf7e@siemens.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=toshiba-tsip.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYWPR01MB8510:EE_|OS3PR01MB10187:EE_
x-ms-office365-filtering-correlation-id: 24386eab-bd50-4600-c191-08de16d2357e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|376014|1800799024|38070700021;
x-microsoft-antispam-message-info: 
 =?utf-8?B?cm9DREU3TGZHVy9GeHQwdHFoWEp0b3U2a0xOdTlXandUK3llaGlFbzJ5eGV5?=
 =?utf-8?B?djdlMDUzWTVJTFlTS2VTcmlQRnZZR0ZhYWRRc09hdGJEN2w5aDdIdnlyY3RU?=
 =?utf-8?B?emVpYlorWHl4Zm1HUE8wVnlDQmx4Ukh3US9GRW5XUTJHUmpsRTRldzYxRHc0?=
 =?utf-8?B?Tk42SndJOEk1cWxRVGNrcnZxTXRZK3RkUVNuSTVVRmZEUUhxS05DNndkbXRy?=
 =?utf-8?B?UDMxUHdDNE81NVlaZGJBZ3UwOHdhbVR1TnBFV2Y5VFd6Q0N0V09UR28vY3NZ?=
 =?utf-8?B?TFdiYy9IQzNFTFcxbUwzUDZQd0ZpK20vM29zNkZ4VitmS3BrKzk2ODJaT0F5?=
 =?utf-8?B?K0NGTTlrUTJSV0x1cURYdHNIakJvczhvMm5QdDlQU0ZPemlaczZaZzZrOGE0?=
 =?utf-8?B?b1FjRFYxNUw4YU1PamovcUduMVJOUnRmV0Z2UE5aSSt5UGFrV1VZQTY0T0Ew?=
 =?utf-8?B?YnVGLzRKMXk4blB0bmJwNnJhb1Q4cnowRTcwSk5iUy9HaVNEWW1JQlNkMW9o?=
 =?utf-8?B?c3JFTkNMeFl0TWhIQ2hGTVFkNkpNV0tIS1dSNjBNbEwwdnk2N3lpeHpwVGMw?=
 =?utf-8?B?SGNpS1lac2tFNldwVVArV2JVRzZLZU9iZ2JUZldKUTJLWVU1cjdIYThXVkJH?=
 =?utf-8?B?ZmNLM01OdUtlblB1NklyclkrL0pvZkNjbEtOUTdsOGM1NkJMVVREQlV0VlU3?=
 =?utf-8?B?QlkrNk0zemlvbVZHaDVOQndKQkMvMGhEajMzcnpuYW1GVVlGSUd5RmlXczls?=
 =?utf-8?B?cXlmZEhkRW82dWhmNDAxRldhWnRHdzlHc25DRTY1cytTOXhGTE4vajNHOHJr?=
 =?utf-8?B?d1FlWHRWK3Q4SStZYXFlWkhwQUk3QlpwclBjejhzTnR5cDl0Smp3QXhhM3Z4?=
 =?utf-8?B?SGhQdkhOMXhMbEVvcnh3OEQvSXkwZnJvM2EzYURWTTE1d1FHTGpUS0tPZ2hl?=
 =?utf-8?B?V0tONXo3UFlMTmp5dkRCTW94cmdIRSt3NnRVc3NDTE9oS1FXK0dLSGhEOS9I?=
 =?utf-8?B?N1oyL1hMOUFuSTdsRklYeGhZSS9ITi9ScDVIOTNtNThwQVY2cVN1YVNVcGNX?=
 =?utf-8?B?OXh4UTdnRC9aRDBuQ3dZWFFYRmpTKzVmOG5peHRlamZ4bXRVUUlOQm1RVGw0?=
 =?utf-8?B?bHBIbHA0WjV4bHA2SVNkbzB1SjV3MGZsdThKSHhiL0IvbGw5ZmRvUXZZK1Bm?=
 =?utf-8?B?NlFUbU96MXdyc3pJZDdMbllDREgyOTFReERlU2I2Y29lMER4U0ZTOXltUmdC?=
 =?utf-8?B?MVl1M1BmbWYwM01KM1pUYy9CN1BIaHVVV1E2QndLVDJQZmtqcnNHMGtlTzdx?=
 =?utf-8?B?UjlNWjZzQmFOdk45Nkx2dDZKM1F5dXI3SmE0c21MZys0YWlRcFUybGk2cXFq?=
 =?utf-8?B?U3pDTnZva0ZMSS9MZmtBZnpDNTQ0ZTZNdDBxVDFvMHI1dWZxZ3BxNHhVVXcv?=
 =?utf-8?B?cXdwZUpNOXNhdktzamtwSEsvaXI3SHhnaFhpSXlWYzVJSVVaZHBxNFRMN0s3?=
 =?utf-8?B?MEdYcE5qZDdwY0huVTB2V3FMZ3YxTHc3RG5mcFJCcmhPYU45dTZjZ1NYb2FO?=
 =?utf-8?B?Sy9tNTQycno4NUtPL1dQOFl2b3FISUtPaWFzRTNuTjJ1ZGtyTTVmWDFwMkh1?=
 =?utf-8?B?UXRBd3crSmYrU3JLV3g2dUtlWWZUbnhEeGFpT1g3ZTY1Tm92THl0MTNhQy9x?=
 =?utf-8?B?WVlreHlzMjdlaGp3cDdOQWdrdTgyMmRBRUszYlVyM1RZNDA0bFRhNXJoeHEv?=
 =?utf-8?B?Q01TclZtb3VyQTRpL21PNWpuaVhCd0FuQ3E1TkRUQ2RCUlJhaGJUem5ibUli?=
 =?utf-8?B?dzFwanNwbXNZc3BmWkNGVVBERFo1OVNQVENiSWwzV3dEVmtqRC8vYnB0WHdN?=
 =?utf-8?B?ZVZGQ0t0RVI2b045ZWVGQXkzbFNHcnYrdHkvdEFwcC8yQ2hxOTNGcWFtbURq?=
 =?utf-8?B?NVZTWDliN0NxYlZhMFovWjNoN0V3c3NGdHJUZUl6S3oycXhKeTdMRHBWVnlx?=
 =?utf-8?B?V1U3VVp3RHZsNHpReGZkdG5lU2o5Y25wUk85L0w5VGUvb0lRQTlGalVSMnVy?=
 =?utf-8?Q?jpWrzF?=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYWPR01MB8510.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?utf-8?B?MDU1VEZPQ0MvMU1IS05Rc1MrTk1PdWJoMVpoM3QwWDlZenB6aFdUUlJCM0Vo?=
 =?utf-8?B?VTlHY0YzUHNzamlyTTF6clpxTEZJWXJwSEVVY0VkU1dlTUhmZCtJZHBqZHZW?=
 =?utf-8?B?V2NhWWk4RFpxUU5KdE9ZdTBmVEIwUGlla280djE1NXNCckw3QVMvck51MnNU?=
 =?utf-8?B?clpIRUZURUJPS0RxZ2ozYVlNSHlkQVJhcStjQnpWQjhhRHRROEhnNHV3NFpU?=
 =?utf-8?B?RGliN2JORU11L0p3WmhpUmtOQ2FTeE5RaXBZQ3RJWkkxQk14akxHekJlaDBk?=
 =?utf-8?B?cEpFSjV6OTBxOUJRS0V4b1VYbkxoZElkWEV5QjZQWVBhUEZDY0w3T0Fsa1FM?=
 =?utf-8?B?eVVVdzcveHdNWnhNWG5kbmZEbnRFUHpjQXRFbUFPbjV5QlRNYXRCZDZDaWNa?=
 =?utf-8?B?d3d6MlZsTjJkNTZNbmVuK24yTDgrWXRSVTN5THlRVE1uN2xvWVFFWWZYMjli?=
 =?utf-8?B?VjMzakNya1FVOE04MTdVdmcwRU1WMDhGOFZtME81YjNYcmh1S1hMWDJhUzRL?=
 =?utf-8?B?eXpsMmczQjhBVmwreC9HWklyeTVIZURmMHROSStOditRMHU2bTdXZnVlekpz?=
 =?utf-8?B?VXB6c1dkWkR5VGUyZTJ5dlZSRWFxUTMwK2tJcUJXYWx5QXRCZmIwK0taY2lx?=
 =?utf-8?B?eWhIellRakJ4VHF2c2tjcWNoNE5ML2h0MVBDYjROVmN1YXJOZnIyNkY3Z2RY?=
 =?utf-8?B?S2JUS1E4QnpGRFRDNkxrUUhhcmhUbmVDOC9GbjN5NTFaRXhsZUh3RzNsZ21k?=
 =?utf-8?B?T0dkTXErUG1mYk5yczRZUFZKaTdhd25lcDJtRE43UnE5L3AxTW9WYmFBOWdR?=
 =?utf-8?B?MlV5TWpXOVZ2Q05WVk1MRG9ZWjZrb1U3c0ZteC95alZxVlQ4SVE1WmlNdXV4?=
 =?utf-8?B?aEc4elo5RjVpQWZvUzRsaDZwS05oeU40eHR2azdMd0NNZC9ZbEJ0YkhXYjV6?=
 =?utf-8?B?ekE2WW1hQkRDTllNeCtpUit2endkT25ENHg0YkFmWGtYWjlidWczWmt6R2Vx?=
 =?utf-8?B?Sld4UTA4RDdRdFVEbnRBbnBYUzBXOVF1Vml6TkFyNjhHYmF4NXdUSjlCSjE5?=
 =?utf-8?B?cDd5eEJ0eFhwTVQydXZpWUpQQ0xhNGowUmQyZzlnS3dXdGZJUVUzdnAwS3lj?=
 =?utf-8?B?UG1RcjBZNERiWDZsV0R0ZHU5dTRNSTZBaXZZbUtjZndYZHdldkpqYjZVRmVu?=
 =?utf-8?B?eDI0NnNSYXpaUGNzS0FocGx4cWZHY0IvSHhsWUQxNmpvSTBJU3RwNk5FcFhw?=
 =?utf-8?B?WWNQUGQrSVF3VmJ0eU5jY2RLenI1S3l3enpMN2ZFRFBJUnprYmlUNCszNW9E?=
 =?utf-8?B?a2w3eEpQQ0htM3NVcUVyWWNESEdZcmlTbzBnY3hZek5ydTA1YWhRbWF4MUxv?=
 =?utf-8?B?L1o2bnd5a29tTGxTbHhSTWZzUkZxU0RuTC9LV1JJemhmZG5RQUVoQzhvVm54?=
 =?utf-8?B?RUxsdjVEN0NaY3QrQ3BlZU5zaDMwUEZQR2w2RStoZ1ltd00vUTA5Q2NhS3JC?=
 =?utf-8?B?bERjbE4wNStJNmpKQ0VyQUt4ckR1MHFIWXdsZDY4eW0ycjhRSUZtYVh6QURS?=
 =?utf-8?B?dnRlWnU1TzdOQkRqNWx2U3N5QVQ3OHNqcE50bXFiZDRhMHdDMVozeVdINGFm?=
 =?utf-8?B?VXgvSUIyQVltb0Z0cUs3RFhzZFNkbys5RDBGQWl2TjZnempuNzlCOVphNmg2?=
 =?utf-8?B?ZnRrc2RJR1J4dm5GN3pUUmZDcURNRVBZcThoRHRlYW9tN1ZnbWV0NVNvREVt?=
 =?utf-8?B?UUp3Wk1QYllOM3NJZ01wb1EwVUV6MkdVMVFiUENIcklVTmp4TmJiWkZhWmRl?=
 =?utf-8?B?RzRZV0dGb1JjRU5IcHMrYi8yMmNYbG15aVg0ZVJwZ2JhS3pQU1Y2VGpyWW8y?=
 =?utf-8?B?enA1WEdNNVlZNnQ4djJ2TnY5NEhKMUhUWk04UWQ5ODRhSUJxdXlrZ3VFYUNG?=
 =?utf-8?B?WDFwc3dJRGZVckZnSEFabjVtTnFiUTBGV25TUXRGamRsSmxDQU5zTzhKdUV1?=
 =?utf-8?B?bXFxS0Ezd2N6d3FtUWIvc2JvVXdpT2ErYjc3cC93SjlaL2IvbzJwRCswOUNy?=
 =?utf-8?B?ZkZDbG1QZldRQjFwSDVmZkhqeWRTc2U5aVpUZmxXcW0xeHhFUElpYW1CNE5E?=
 =?utf-8?B?KzZaLzVObzU4YjBOVFFGamROZE1WbjdFaTZRNTVPN1VQUk11MWdzUmpsd3JY?=
 =?utf-8?B?Z2c9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: toshiba-tsip.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYWPR01MB8510.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 24386eab-bd50-4600-c191-08de16d2357e
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Oct 2025 10:02:02.9276
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f109924e-fb71-4ba0-b2cc-65dcdf6fbe4f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: SUYEr0bb2WxxqRLfyy1yVRTD45+p6zFT7I2wh4rjBDWwhLwAxsdRjR6xktGW11Ew9TcHmV1yTBh4y8YWw2AGnx8iG/qCyLrmL859CVvl7xQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS3PR01MB10187
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 29 Oct 2025 10:02:16 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/20274

U3VyZSwgcGxlYXNlIHVzZSBtY29tIGZvciBUcml4aWUgdGVzdGluZywgd2UgaGF2ZSBvbmUgZGVk
aWNhdGVkIG1jb20gZGV2aWNlIGZvciBJRUMgdGVzdGluZyBpbiBUb3NoaWJhIEJhbmdhbG9yZS4N
Cg0KSWYgd2UgY2FuIGtlZXAgb25lIHFlbXUgdGFyZ2V0IGZvciBib29rd29ybSBmb3Igc3d1cGRh
dGUvc2VjdXJlIGJvb3QgdGVzdGluZyBpdCB3aWxsIGJlIGdyZWF0IGF0IGxlYXN0IHVudGlsIEUv
SmFuLTIwMjYuDQoNClJlZ2FyZHMsDQpEaW5lc2ggS3VtYXINCg0KLS0tLS1PcmlnaW5hbCBNZXNz
YWdlLS0tLS0NCkZyb206IEphbiBLaXN6a2EgPGphbi5raXN6a2FAc2llbWVucy5jb20+IA0KU2Vu
dDogV2VkbmVzZGF5LCBPY3RvYmVyIDI5LCAyMDI1IDM6MTQgUE0NClRvOiBkaW5lc2gga3VtYXIo
77y077yz77yp77ywIERJVENfRElULU9TVCkgPGRpbmVzaC5rdW1hckB0b3NoaWJhLXRzaXAuY29t
Pg0KQ2M6IGNpcC1kZXZAbGlzdHMuY2lwLXByb2plY3Qub3JnOyBoaXJvdGFrYS5tb3RhaUBtaXJh
Y2xlbGludXguY29tOyBoYXlhc2hpIGthenVoaXJvKOaelyDlkozlro8g4pah77yk77yp77y077yj
4peL77yj77yw77y0KSA8a2F6dWhpcm8uaGF5YXNoaS5mNzRAbWFpbC50b3NoaWJhPjsgcGFzcXVh
bGUubmllZGR1QHNpZW1lbnMuY29tDQpTdWJqZWN0OiBSZTogW2NpcC1kZXZdIGlzYXItY2lwLWNv
cmU6IFNoaWZ0aW5nIGRlZmF1bHRzIHRvIHRyaXhpZT8NCg0KT24gMjkuMTAuMjUgMTA6MTEsIGRp
bmVzaC5rdW1hckB0b3NoaWJhLXRzaXAuY29tIHdyb3RlOg0KPiBIaSBKYW4sDQo+IA0KPiBUaGF0
J3MgcmlnaHQgQ0lQIElFQyBjZXJ0aWZpY2F0aW9uIHVzZWQgYm9va3dvcm0gYmFzZWQgaW1hZ2Vz
Lg0KPiBIb3dldmVyLCBpZiBpc2FyLWNpcC1jb3JlIG1vdmVzIHRvIFRyaXhpZSBpdCBkb2VzIG5v
dCBhZmZlY3QgYW55dGhpbmcgZm9yIElFQyBjZXJ0aWZpY2F0aW9uIGFzIEJWIGRvZXMgbm90IHVz
ZSBDSVAgQ0kgdGVzdCByZXN1bHRzIGFzIGV2aWRlbmNlLg0KPiANCg0KVGhhdCBnaXZlcyB1cyBz
b21lIGZyZWVkb20uDQoNCkdpdmVuIHRoZSBjdXJyZW50IGxpbWl0ZWQgYXZhaWxhYmlsaXR5IG9m
IHRoZSBtY29tIGRldmljZSBpbiBDSSwgaXQgd291bGQgbGlrZWx5IG1lYW4gbW92aW5nIG9uLWRl
dmljZSB0ZXN0aW5nIHRvIHRyaXhpZS1vbmx5LiBBIHNsaWdodCByaXNrIG9mIG1pc3NpbmcgYSBy
ZWdyZXNzaW9uIG9uIGJvb2t3b3JtIGNvdWxkIGFyaXNlIGZyb20gdGhhdC4gSWYgdGhlcmUgYW55
IGNvbmNlcm4gYWJvdXQgc3VjaCBhIHRlc3QgY29uc29saWRhdGlvbiwgcGxlYXNlIHJhaXNlIHlv
dXIgdm9pY2UuIFdlIGNvdWxkIGtlZXAgYSBxZW11IHRhcmdldCBmb3Igc3d1cGRhdGUvc2VjdXJl
IGJvb3QgdGVzdGluZyBvbiBib29rd29ybS4NCg0KSmFuDQoNCj4gSWYgQlYgcmVxdWlyZXMgYW55
IG90aGVyIGFydGlmYWN0cyBmb3IgU1ZWLTIsIFNWVi0zIGFuZCBTVlYtNCB0ZXN0aW5nLCBTV0cg
d2lsbCBzaGFyZSBmcm9tIGJvb2t3b3JtIGJhc2VkIHJlbGVhc2VzLg0KPiANCj4gVGhhbmtzICYg
UmVnYXJkcywNCj4gRGluZXNoIEt1bWFyDQo+IA0KPiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0t
LQ0KPiBGcm9tOiBjaXAtZGV2QGxpc3RzLmNpcC1wcm9qZWN0Lm9yZyA8Y2lwLWRldkBsaXN0cy5j
aXAtcHJvamVjdC5vcmc+IE9uIA0KPiBCZWhhbGYgT2YgSmFuIEtpc3prYSB2aWEgbGlzdHMuY2lw
LXByb2plY3Qub3JnDQo+IFNlbnQ6IFR1ZXNkYXksIE9jdG9iZXIgMjgsIDIwMjUgOTozNSBQTQ0K
PiBUbzogY2lwLWRldiA8Y2lwLWRldkBsaXN0cy5jaXAtcHJvamVjdC5vcmc+OyBkaW5lc2gga3Vt
YXIo77y077yz77yp77ywIA0KPiBESVRDX0RJVC1PU1QpIDxkaW5lc2gua3VtYXJAdG9zaGliYS10
c2lwLmNvbT47IEhpcm90YWthIE1vdGFpIA0KPiA8aGlyb3Rha2EubW90YWlAbWlyYWNsZWxpbnV4
LmNvbT47IGhheWFzaGkga2F6dWhpcm8o5p6XIOWSjOWujyDilqHvvKTvvKnvvLTvvKPil4vvvKPv
vLDvvLQpIA0KPiA8a2F6dWhpcm8uaGF5YXNoaS5mNzRAbWFpbC50b3NoaWJhPg0KPiBTdWJqZWN0
OiBbY2lwLWRldl0gaXNhci1jaXAtY29yZTogU2hpZnRpbmcgZGVmYXVsdHMgdG8gdHJpeGllPw0K
PiANCj4gSGkgYWxsLA0KPiANCj4gd2UgYXJlIGN1cnJlbnRseSBzdGlsbCBwcmVmZXJyaW5nIGJv
b2t3b3JtIG92ZXIgdHJpeGllIGluIGEgbnVtYmVyIG9mIHBsYWNlcyBpbiBpc2FyLWNpcC1jb3Jl
LiBMaWtlbHkgbW9zdCBub3RhYmx5IGlzIHRoYXQgbW9zdCBvZiBvdXIgQ0kgYnVpbGQgYW5kIHJ1
bnRpbWUgdGVzdHMgYXJlIGJvb2t3b3JtIGJhc2VkLiBJIHN1c3BlY3QgdGhhdCBhdCBsZWFzdCBw
YXJ0cyBvZiB0aGF0IGlzIGR1ZSB0byB0aGUgb25nb2luZyBjZXJ0aWZpY2F0aW9uIHdvcmsgd2hp
Y2ggd2FzIHN0YXJ0ZWQgb24gYm9va3dvcm0sIHJpZ2h0Pw0KPiANCj4gV2hhdCBjYW4gd2UgY2hh
bmdlIG9yIGFkZCB0byBtb3ZlIHRyaXhpZSBtb3JlIGludG8gZm9jdXM/DQo+IA0KPiBKYW4NCj4g
DQo+IC0tDQo+IFNpZW1lbnMgQUcsIEZvdW5kYXRpb25hbCBUZWNobm9sb2dpZXMNCj4gTGludXgg
RXhwZXJ0IENlbnRlcg0KPiANCg0KLS0NClNpZW1lbnMgQUcsIEZvdW5kYXRpb25hbCBUZWNobm9s
b2dpZXMNCkxpbnV4IEV4cGVydCBDZW50ZXINCg==


