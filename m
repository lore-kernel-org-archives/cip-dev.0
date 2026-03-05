Return-Path: <nobuhiro.iwamatsu.x90@mail.toshiba>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2BA24EEF334
	for <webhook@archiver.kernel.org>; Thu,  5 Mar 2026 09:03:42 +0000 (UTC)
Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.158])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.40050.1772701413693889833
 for <cip-dev@lists.cip-project.org>;
 Thu, 05 Mar 2026 01:03:35 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=nobuhiro.iwamatsu.x90@mail.toshiba header.s=key2.smx header.b=Gi4HT9TS;
 spf=pass (domain: mail.toshiba, ip: 210.130.202.158, mailfrom: nobuhiro.iwamatsu.x90@mail.toshiba)
DKIM-Signature: v=1;a=rsa-sha256;c=relaxed/simple;d=mail.toshiba;h=From:To:
	Subject:Date:Message-ID:References:In-Reply-To:Content-Type:
	Content-Transfer-Encoding:MIME-Version;i=nobuhiro.iwamatsu.x90@mail.toshiba;
	s=key2.smx;t=1772701411;x=1773911011;bh=k4IbWhe50QJ9NbBd4nrh2WitTOF/z666AO1ZF
	HO19eo=;b=Gi4HT9TS8NIoWnY0uLDshJvZjQR2tg6OkU65erCRLn1GZZC+dc7jkqQnO3+hMP+hudq
	lvrn3aIiC0DCHUFGhDRBt653aIwHHQkl5L/Myg/MHq3oOO4rdIQWKY+lV6tNRXS8gBWKjcJ+SXhf0
	5kQ8v40iT2e+pp8ow1mRsK+JCNYpiVUHeEKQbnvOjFDxGQRYD5yfsrupkXuQOg6hK1To5qX2577n9
	Qd8FckJ5AGCLosf4Z7/7DfsS5/WSa5DAYaKvfHkZQhXCZv3cf5cqT0X7LKRHINmx+PP4p9aQHIB8n
	JH4cVEmMyYeWhYxEhn4AXk83C7UH834aBzpFrF2zbHzQ==;
Received: by mo-csw.securemx.jp (mx-mo-csw1122) id 62593UxJ2123928; Thu, 5 Mar 2026 18:03:31 +0900
X-Iguazu-Qid: 2rWgk9kdvtv6jaqdMR
X-Iguazu-QSIG: v=2; s=0; t=1772701410; q=2rWgk9kdvtv6jaqdMR; m=PKd4gAITncWXRMSZQuef3y2Wayz9MlH5JjSFRs0+QOw=
Received: from imx12-a.toshiba.co.jp (unknown [38.106.60.135])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	 id 4fRNqk2hJfz4vyq; Thu,  5 Mar 2026 18:03:30 +0900 (JST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tJ8r3/QLSr5xZzR61DWwEZyyC7qRiPPpgqUfY9lVbZ+KK63Jw5VMHZUlLyq6Y34/B35aS6bUVZ5cWqtuZrvCaM+MFFK2+3ky4B0NqevVfyaf5ewn4CdV3rAAEtJWanVEGCi5LfGD8Ue9L5REbrxBmrS2oWRnabg06j/6hIy07ZzI/8TZT8qKDEuRM3LY2r9HXL/7rxqjiFDaHMeEh+VgYb/vNPxGBKJajWrpFaHXbRwEBnOz9wkJhaJmFifgtMIbv0/zHmngmqldjfWd8sajJCM0WQNUwimmrvEWkLRw13q3vdCDm3e+/qYjyf9rIor4XEZJaExXwYfGwXa/8FHI+w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=k4IbWhe50QJ9NbBd4nrh2WitTOF/z666AO1ZFHO19eo=;
 b=YuzeyPKX1y5/RrDR25GH9CZfc8LO0KA/ew7amGERblZtYK7lMBLUhzoiEZN3NApRP+865Tw8oEaAYb4ELV3Pz55aWF0xxytufV2j+e3qYhmQRZ203psCa7XXV/9mkawHfjaA4kHOTRr1jsHLpZOt+ilfYxgvCYI7uhxNRL+Y9FJKGxkBK9sXNhgQtWCvnUS2A7P5395rvCQG8Zc0I58h641Q4U9ZVgFKPPxKycFt2aylCAsGQbrW0MGOyN/wnfR3XI2vmaQyGIP3cCvwUpf/f9lkEFrkAOHJpiPEgOUhSo7lnLpr3gje/+hLjeQVPASycOABqkXOvTGx5yW8hn93oA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mail.toshiba; dmarc=pass action=none header.from=mail.toshiba;
 dkim=pass header.d=mail.toshiba; arc=none
From: <nobuhiro.iwamatsu.x90@mail.toshiba>
To: <jan.kiszka@siemens.com>, <cip-dev@lists.cip-project.org>
Subject: RE: [cip-dev] CIP IRC weekly meeting today on libera.chat
Thread-Topic: [cip-dev] CIP IRC weekly meeting today on libera.chat
Thread-Index: AQHcrGYPXibnvuAyrE60TMLsd2X3j7WfpOlw
Date: Thu, 5 Mar 2026 09:03:27 +0000
X-TSB-HOP2: ON
Message-ID: 
 <TY7PR01MB14818CBD0C1A1B643201BBF21CD7DA@TY7PR01MB14818.jpnprd01.prod.outlook.com>
References: <7231117b-e350-4f03-8f3c-1dbeb4dd5f37@siemens.com>
In-Reply-To: <7231117b-e350-4f03-8f3c-1dbeb4dd5f37@siemens.com>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mail.toshiba;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TY7PR01MB14818:EE_|TYCPR01MB9400:EE_
x-ms-office365-filtering-correlation-id: 87e4321b-599a-4796-2e28-08de7a96106c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|376014|1800799024|38070700021;
x-microsoft-antispam-message-info: 
 20jJnVAaiVVlM4aSNaxWr6ldQJUMwC7XiX0DN9nuadYbjnLKXSZtUBNlxKU9e3Tn7OmMVXVpIKKKlHy/TcXnjK+/iKrIfEAgsEoZlYMiEl+WCk6wozxba81Pv5fo4pdAqkGHWyRyvB3oxaglWlV7IExq+y12o3Odu05Tp14l0TkCZFw2pBy7/+pT+Ms3aTnEbwcVw/EVhSoHPg2QxJBMCwkh/B3Xt6ANKCW2BqjDYc+rWmOeVI5hbnmUr1Vxenv1kAcQ2v1U5ymoYXLRqLFuSnV3CFCucUkkeIWW8xuOGat4iK+9z77t1RCOP5WihrDxaSR84NWPuU9vB+utcV+KuUbzMDGeLUleQPin9nvjhlKF3S7bf2PSJ4lNdvNtjmCoK3yZzvmWra0DUamb24ES8ioYlAz6h1HBEz6rLzUHDnLgxd88GRDXhyy7RXc/XMdAGeNI5tbU5Arv1E0+BGijcdob/6AbyDdnkCyQ4OT/0Fx5BDchiESw/k/UIo9iFqblwNGxnIQiYkrR5ZkMxnqmR81roby4plnsHBt3C3EVBcI9/A/Zy2lj4SRJlXinxZ/QYVvWgq7+OHK1gmKuBTmvlx0n2jjm/J+kszKye0Mv/wDOH9/wzQI/Ry50XLcjVo1jE9tvcfr8zWDAxceAXQVLGAijUNv5F7raVnpln1Z3TNacb4H3jRRYpvnhnR+wz6RARc8EtJEcrJ+yxDVm0/xlHjmDgaN0M9YvPBAUeq6fLyyoov4a2BfONJPwWWRt4Dmd
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:ja;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY7PR01MB14818.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?utf-8?B?RlZ6YUVtamtDR1pxN2xGeGJqYmJMVHdnSHZaSGJVYjN1SXBtQXdWQWd3Qk1a?=
 =?utf-8?B?VjZOcVlRbHFWcUF4aFRSVU1jZnd0enJKdDI4eXkvWlFQK3BkVjM0bDc0QnhU?=
 =?utf-8?B?NCsrUXVYeGhWNUZHMGwwbzU5Y2sxY0tNZXl0ZFFUTVRtdXFNVVFpZ0cyLzFW?=
 =?utf-8?B?eWxHQmFWQkFsTUVxT3BwNG5LMVROVDI3bFhrRTFQaHM4d1pSVTB1RE43UkFi?=
 =?utf-8?B?Rk1yVUhTNEpEaGRQWkFSd000cUh2TWYzWlZ0UFcyaDN1aFllVTUvWnZtV3lw?=
 =?utf-8?B?TWNWaThVQWc0S2xyK29GUjJpaWVUWUNYbThyVjNXZ0V3bk12bVZDcU1xRnJL?=
 =?utf-8?B?K09iQXpaelFKTldJOUNWR05idXo1cEpJMXM4YUNzZVIwV0V4QkpxUGFTYWF4?=
 =?utf-8?B?SzlXUTZxRTAreHlhQXExdDZsb0U5TmVGU0huR2ZOVnFRdDlZN01UbndQSEVa?=
 =?utf-8?B?SU44eXNlWDI4K3dIc3hVbVNGdWpMN0F2RlF6RHNNdk13UldMbjFjZ0Y1QUp4?=
 =?utf-8?B?VkwvSXR1ZG4yTXJPcVFES01WTlFEbWtzMGpPNEJVYVRXTVlPOU5BRDFxTmFz?=
 =?utf-8?B?cXZnTTlJVGt4TytEUGlocEsrSzhzZGlGbFlrWHMwaW9FWW1NZXFlbURMU01n?=
 =?utf-8?B?NUFrdEZ2N3ZyeVVjbGVWUmV5U2tETldoVUhNcmJOMkt2Sm8yS0c4WlhoQ2RJ?=
 =?utf-8?B?bm5oeG1aMTIyMTFCWWlwN2c1d0xRbm9ydDNBYURCcHhzcUU2a1lGWnpxY0Rl?=
 =?utf-8?B?Uk5wb2Y2M2ZhWXZKY1NqMnp6blYyN3NMbU9JZEFqbERUTW9Rd1VrcmQzWUFT?=
 =?utf-8?B?WE5MbjRuMW0ydTdQUjl5NS9uVVd6NmI5b1NVcEFXMlM4WmhId2gwRUUrZTh0?=
 =?utf-8?B?UmZsYktVQ0xkTXhsNGpoWXRISkEwVlhjR1Q3ekdDNFJRSW52eDZQZzJrRWJi?=
 =?utf-8?B?UG1sV216V2EzU3FORFhUL0F2ZFh1cEQ0RmZQbThqYTgrRjhQTTBwTHF0LzBT?=
 =?utf-8?B?OTFzcjZoYzd3MU94cGF1NUs2UCt1RG9ST2I0bTl2dXFaV1RtcFBHbGd4WHpv?=
 =?utf-8?B?MWR5MXJsQXoya054NnpPUUhIWlJLUXdvM3BDc1dtUFVXdmVnellWU3c2c2Rt?=
 =?utf-8?B?YlYzRlBIV1d6NjlSenlHdnhPZzZaN2FxOXV2eFN3MGlHZk5NK2F0dHJuN2M0?=
 =?utf-8?B?b0N4Zng2Q0VMQ0lLd0FsVjhHVmdtc3hoT0hYWlU4d2xEZGxXWFRXL21NazhR?=
 =?utf-8?B?NStzVmVmSDY5QUZVWkJjNExxOWRpcG9aRDFZbEQ3MXlEN2ltZ29PdWZ6amlH?=
 =?utf-8?B?WGczRXNOUXRlKzQreU5aSlJvSlBZNU5odUpqNmNWOTFFV20wNzFVUnlleFoz?=
 =?utf-8?B?WXFTY3lBQ3RLdUpFRlpKZmljNU1ZRG1yYk0xR0N0TTVLbE85b0V2RWhodEtz?=
 =?utf-8?B?RXM2b2Y5RVh0ZXpBWkpHbVU3K3oxSUdGaHZGUkluaCtuYzF3Rk44MkVWck1G?=
 =?utf-8?B?b0x1TFdTMXV1OHNwcDVxM29CcGVxWnh1RVBMOGkwbTlmdlZZanBDNjN3QTBa?=
 =?utf-8?B?NHdleWNXbmxvTGNsUFR1SjExN3RLVVphaU1UUHFNeHBHc3laRnpHNVJORXFE?=
 =?utf-8?B?bFZTWVh5TUFxcjFVUHZ0L3NQS3Q4S1RSbmZrLzNCcURCbUlISDc5dmMvSFpr?=
 =?utf-8?B?bFpSTjN3RXJRV2xCV1ZDTEhsNHhieTM2QTRiaDk5VituTnF3V24zTFVNcjJS?=
 =?utf-8?B?Wk9RdisxSnlIRWlhRHZyUEFBNS90MjVVQjF5SGRJbVBuN1FzMlNKOXZ3QXha?=
 =?utf-8?B?aHRZejRDOVRKaTBOdzZNdFJFb3ZZUWtsdUR2Nkp6dFJuZjFIV2lGUmRpMkpu?=
 =?utf-8?B?bjZxZ0hTTWVCTENtS3BxQTNBMnJZdkNwTlc3cGtPcnpxYityQjZHcnYzSG1m?=
 =?utf-8?B?cWd1RTV0eG8rK2lpbmk3Sm5KdzNqdUZjUEd4NXkyZkxRSk42aC8wMmpnZmlM?=
 =?utf-8?B?M2QxMU1lRHNiYUNKM0ZValpmTnh4TGY0M0tOLytPTlRUSitrSGRTOTV4czQ4?=
 =?utf-8?B?OUVERXE0U1dwZEdzV01jNlJaNFpEdnRSeGNKcHVZSXZuNlFNbHpiQmZpNnQy?=
 =?utf-8?B?QkpXWlJ2Mm53UjU5MmhPcnRMN1k0bUp4YWlFT3RvdHdOcjNveksreUFabXVW?=
 =?utf-8?B?Z3AzUWxHR092NC9LRktDWnVwd1EwR2x5VEFpbHd3ZVAxL2ZTR0ZJd1lBYlM0?=
 =?utf-8?B?L29xR1VHVERCN1BMbVNFQWw5L2ZseW1RMDFXWkFmbENQM3AwTG13NnY5d2dv?=
 =?utf-8?B?Y3ZjaksvOEgrTkZoUE5HV2VESlQ3b0FDSFVlemsyalVvV2NMTUhlUmppN1cy?=
 =?utf-8?Q?z9xnlZCHarvLNCEI=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: 
	v/T3eCqcI+er+6E9TnHUDiZJQpqGyEqC5BlYXYKCeF41+xCScBNRwWwCvPJb+8qWhE9wh+aLqkG55YjkWJIJpT/TFmooTanhfnE+QBSuYq+f8C15wJhmyKN1b3d9G6DyBCCsZ8JiO60EWwwDLRPW5P2QIE2HA83O+kwL80b3Tci0NQCb490YPpk6DUqQWWTkh3bpaPbpXpLdy7sjEfktTQgDGr2JfIXLN/B4aISUsom9LJqfaIx6bXLZxQ49PrJaL9ho5N9/DtgUDRvSn+imJvruK22+nJWetKhvPixK65N/r0CP0DhO7oHuX/hkT/RUgrsZCWc8fcGCUV2pxSnRfA==
X-OriginatorOrg: mail.toshiba
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY7PR01MB14818.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 87e4321b-599a-4796-2e28-08de7a96106c
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Mar 2026 09:03:27.2272
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f109924e-fb71-4ba0-b2cc-65dcdf6fbe4f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: hSJsD40Cn7rtBSxRMsjo6GPl0vjuhrT7qt6CEMESziZiQ6RTnvuJK7DKpdz74qqerF2Hofiw2F1rQMt1JX1WQvoHt+LNc6hUvFem6fgwkXMgHIRx8d5AtkdV3mbOyL7K
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYCPR01MB9400
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 05 Mar 2026 09:03:42 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/22079

SGkgYWxsLA0KDQpJIGNhbiBub3QgcGFydGljaXBhdGUgdG9kYXkncyBJUkMgbWVldGluZyBmb3Ig
cGVyc29uYWwgcmVhc29uLg0KDQo+ICogQWN0aW9uIGl0ZW1zDQo+ICAgIC0gZW5oYW5jZSB3aWtp
IGFyb3VuZCBib2FyZCBzdXBwb3J0IGJhY2twb3J0cyBbamFuXQ0KPiAgICAtIHByb3ZpZGUga2Vy
bmVsIGNvbmZpZyBzbmlwcGV0cyBmb3IgbG9ja2RlcCBhbmQgcnQgW2phbl0NCj4gKiBLZXJuZWwg
bWFpbnRlbmFuY2UgdXBkYXRlcw0KDQpJIGRpZCBub3Qgd29yayBvbiB0aGlzIHRoaXMgd2Vlay4N
Cg0KPiAqIEtlcm5lbCByZWxlYXNlIHN0YXR1cyBbKl0NCg0KSSBhbSBjdXJyZW50bHkgdXBkYXRp
bmcgbGludXgtNi4xMi55LWNpcC4NCg0KPiAqIEtlcm5lbCB0ZXN0aW5nDQoNCkkgdXBkYXRlZCB0
aGUga2VybmVsIGNvbmZpZ3VyYXRpb24gdG8gZml4IFFFTVUgYm9vdCBpc3N1ZXMgb24gYXJtNjQg
YW5kIGFybWhmLg0KICAtIGh0dHBzOi8vZ2l0bGFiLmNvbS9jaXAtcHJvamVjdC9jaXAta2VybmVs
L2NpcC1rZXJuZWwtY29uZmlnLy0vY29tbWl0LzA0MWE2NDc4YzRiOTY3MDZlZDhlMDVlYTFmOWIz
MmM4NThlMGZkZGYNCiAgLSBodHRwczovL2dpdGxhYi5jb20vY2lwLXByb2plY3QvY2lwLXRlc3Rp
bmcvbGludXgtc3RhYmxlLXJjLWNpLy0vcGlwZWxpbmVzLzIzNTkxNTM5MDcNCiAgLSBodHRwczov
L2dpdGxhYi5jb20vY2lwLXByb2plY3QvY2lwLXRlc3RpbmcvbGludXgtc3RhYmxlLXJjLWNpLy0v
cGlwZWxpbmVzLzIzNTkxNTI5NjANCg0KPiAqIEFPQg0KDQpCZXN0IHJlZ2FyZHMsDQogIE5vYnVo
aXJvDQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogY2lwLWRldkBsaXN0
cy5jaXAtcHJvamVjdC5vcmcgPGNpcC1kZXZAbGlzdHMuY2lwLXByb2plY3Qub3JnPiBPbiBCZWhh
bGYgT2YgSmFuIEtpc3prYSB2aWEgbGlzdHMuY2lwLXByb2plY3Qub3JnDQo+IFNlbnQ6IFRodXJz
ZGF5LCBNYXJjaCA1LCAyMDI2IDM6MDUgUE0NCj4gVG86IGNpcC1kZXYgPGNpcC1kZXZAbGlzdHMu
Y2lwLXByb2plY3Qub3JnPg0KPiBTdWJqZWN0OiBbY2lwLWRldl0gQ0lQIElSQyB3ZWVrbHkgbWVl
dGluZyB0b2RheSBvbiBsaWJlcmEuY2hhdA0KPiANCj4gSGkgYWxsLA0KPiANCj4gS2luZGx5IGJl
IHJlbWluZGVkIHRvIGF0dGVuZCB0aGUgd2Vla2x5IG1lZXRpbmcgdGhyb3VnaCBJUkMgdG8gZGlz
Y3VzcyB0ZWNobmljYWwgdG9waWNzIHdpdGggQ0lQIGtlcm5lbCB0b2RheS4gT3VyDQo+IGNoYW5u
ZWwgaXMgdGhlIGZvbGxvd2luZzoNCj4gDQo+ICAgICBpcmM6aXJjLmxpYmVyYS5jaGF0OjY2Njcv
Y2lwDQo+IA0KPiBUaGUgSVJDIG1lZXRpbmcgaXMgc2NoZWR1bGVkIHRvIFVUQyAoR01UKSAxMjow
MDoNCj4gDQo+IGh0dHBzOi8vd3d3LnRpbWVhbmRkYXRlLmNvbS93b3JsZGNsb2NrL21lZXRpbmdk
ZXRhaWxzLmh0bWw/eWVhcj0yMDI2Jm1vbnRoPTMmZGF5PTUmaG91cj0xMiZtaW49MCZzZWM9DQo+
IDAmcDE9MjI0JnAyPTE3OSZwMz0xMzYmcDQ9MzcmcDU9MjQxJnA2PTI0OA0KPiANCj4gVVNXZXN0
ICAgIFVTRWFzdCAgICBVSyAgICAgICAgREUgICAgICAgIFRXICAgICAgICBKUA0KPiAwNDowMCAg
ICAgMDc6MDAgICAgIDEyOjAwICAgICAxMzowMCAgICAgMjA6MDAgICAgIDIxOjAwDQo+IA0KPiBM
YXN0IG1lZXRpbmcgbWludXRlczoNCj4gaHR0cHM6Ly9pcmNib3Qud2wubGludXhmb3VuZGF0aW9u
Lm9yZy9tZWV0aW5ncy9jaXAvMjAyNi8wMi9jaXAuMjAyNi0wMi0yNi0xMi4wMC5sb2cuaHRtbA0K
PiANCj4gKiBBY3Rpb24gaXRlbXMNCj4gICAgLSBlbmhhbmNlIHdpa2kgYXJvdW5kIGJvYXJkIHN1
cHBvcnQgYmFja3BvcnRzIFtqYW5dDQo+ICAgIC0gcHJvdmlkZSBrZXJuZWwgY29uZmlnIHNuaXBw
ZXRzIGZvciBsb2NrZGVwIGFuZCBydCBbamFuXQ0KPiAqIEtlcm5lbCBtYWludGVuYW5jZSB1cGRh
dGVzDQo+ICogS2VybmVsIHJlbGVhc2Ugc3RhdHVzIFsqXQ0KPiAqIEtlcm5lbCB0ZXN0aW5nDQo+
ICogQU9CDQo+IA0KPiBKYW4NCj4gDQo+IFsqXQ0KPiBEYXRlIHRoZSBkYXRhIGlzIGNyZWF0ZWQ6
IFRodSBNYXIgIDUgMDY6MDQ6MTcgQU0gVVRDIDIwMjYNCj4gbGludXgtNC40LnktY2lwOiBpbnRl
cnZhbCAzMCBkYXkNCj4gICBsYXRlc3QgdmVyc2lvbiByZWxlYXNlIGRhdGU6IFN1biBNYXIgIDEg
MTA6NTI6MzYgQU0gVVRDIDIwMjYNCj4gICBsaW1pdCBkYXRlOiBUdWUgTWFyIDMxIDEwOjUyOjM2
IEFNIFVUQyAyMDI2DQo+ICAgU3RhdHVzOiBPbiB0cmFjaw0KPiBsaW51eC00LjQueS1jaXAtcnQ6
IGludGVydmFsIDYwIGRheQ0KPiAgIGxhdGVzdCB2ZXJzaW9uIHJlbGVhc2UgZGF0ZTogU3VuIEph
biAxMSAwOTo1NToxMSBBTSBVVEMgMjAyNg0KPiAgIGxpbWl0IGRhdGU6IFRodSBNYXIgMTIgMDk6
NTU6MTEgQU0gVVRDIDIwMjYNCj4gICBTdGF0dXM6IE9uIHRyYWNrDQo+IGxpbnV4LTQuMTkueS1j
aXA6IGludGVydmFsIDMwIGRheQ0KPiAgIGxhdGVzdCB2ZXJzaW9uIHJlbGVhc2UgZGF0ZTogTW9u
IEZlYiAyMyAwMzoyODoyOCBBTSBVVEMgMjAyNg0KPiAgIGxpbWl0IGRhdGU6IFdlZCBNYXIgMjUg
MDM6Mjg6MjggQU0gVVRDIDIwMjYNCj4gICBTdGF0dXM6IE9uIHRyYWNrDQo+IGxpbnV4LTQuMTku
eS1jaXAtcnQ6IGludGVydmFsIDYwIGRheQ0KPiAgIGxhdGVzdCB2ZXJzaW9uIHJlbGVhc2UgZGF0
ZTogV2VkIEZlYiAgNCAxMDo0MTozMyBBTSBVVEMgMjAyNg0KPiAgIGxpbWl0IGRhdGU6IFN1biBB
cHIgIDUgMTA6NDE6MzMgQU0gVVRDIDIwMjYNCj4gICBTdGF0dXM6IE9uIHRyYWNrDQo+IGxpbnV4
LTUuMTAueS1jaXA6IGludGVydmFsIDMwIGRheQ0KPiAgIGxhdGVzdCB2ZXJzaW9uIHJlbGVhc2Ug
ZGF0ZTogRnJpIEZlYiAxMyAxMjozMzo0MyBBTSBVVEMgMjAyNg0KPiAgIGxpbWl0IGRhdGU6IFN1
biBNYXIgMTUgMTI6MzM6NDMgQU0gVVRDIDIwMjYNCj4gICBTdGF0dXM6IE9uIHRyYWNrDQo+IGxp
bnV4LTUuMTAueS1jaXAtcnQ6IGludGVydmFsIDYwIGRheQ0KPiAgIGxhdGVzdCB2ZXJzaW9uIHJl
bGVhc2UgZGF0ZTogU2F0IEphbiAxMCAwNzozODo0NiBQTSBVVEMgMjAyNg0KPiAgIGxpbWl0IGRh
dGU6IFdlZCBNYXIgMTEgMDc6Mzg6NDYgUE0gVVRDIDIwMjYNCj4gICBTdGF0dXM6IE9uIHRyYWNr
DQo+IGxpbnV4LTYuMS55LWNpcDogaW50ZXJ2YWwgMzAgZGF5DQo+ICAgbGF0ZXN0IHZlcnNpb24g
cmVsZWFzZSBkYXRlOiBUdWUgRmViIDI0IDA4OjU1OjQ2IEFNIFVUQyAyMDI2DQo+ICAgbGltaXQg
ZGF0ZTogVGh1IE1hciAyNiAwODo1NTo0NiBBTSBVVEMgMjAyNg0KPiAgIFN0YXR1czogT24gdHJh
Y2sNCj4gbGludXgtNi4xLnktY2lwLXJ0OiBpbnRlcnZhbCA2MCBkYXkNCj4gICBsYXRlc3QgdmVy
c2lvbiByZWxlYXNlIGRhdGU6IFR1ZSBGZWIgMjQgMTE6NDc6MzMgQU0gVVRDIDIwMjYNCj4gICBs
aW1pdCBkYXRlOiBTYXQgQXByIDI1IDExOjQ3OjMzIEFNIFVUQyAyMDI2DQo+ICAgU3RhdHVzOiBP
biB0cmFjaw0KPiBsaW51eC02LjEyLnktY2lwOiBpbnRlcnZhbCAxNSBkYXkNCj4gICBsYXRlc3Qg
dmVyc2lvbiByZWxlYXNlIGRhdGU6IFRodSBGZWIgMTIgMTA6MjE6MzUgUE0gVVRDIDIwMjYNCj4g
ICBsaW1pdCBkYXRlOiBGcmkgRmViIDI3IDEwOjIxOjM1IFBNIFVUQyAyMDI2DQo+ICAgU3RhdHVz
OiAqTGF0ZSoNCg==


