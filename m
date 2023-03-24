Return-Path: <nobuhiro1.iwamatsu@toshiba.co.jp>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02C5DC6FD1C
	for <webhook@archiver.kernel.org>; Fri, 24 Mar 2023 06:10:55 +0000 (UTC)
Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.157])
 by mx.groups.io with SMTP id smtpd.web11.94614.1679638253089391746
 for <cip-dev@lists.cip-project.org>;
 Thu, 23 Mar 2023 23:10:53 -0700
Authentication-Results: mx.groups.io;
 dkim=missing; spf=pass (domain: toshiba.co.jp, ip: 210.130.202.157, mailfrom: nobuhiro1.iwamatsu@toshiba.co.jp)
Received: by mo-csw.securemx.jp (mx-mo-csw1115) id 32O6AcfW015514; Fri, 24 Mar 2023 15:10:38 +0900
X-Iguazu-Qid: 2wHHWgyRxQiu1hXkJj
X-Iguazu-QSIG: v=2; s=0; t=1679638237; q=2wHHWgyRxQiu1hXkJj; m=I9FBnufS24VASEsl0G+WLw3OjmjMq/BpWOLTMIXTiwY=
Received: from imx2-a.toshiba.co.jp (imx2-a.toshiba.co.jp [106.186.93.35])
	by relay.securemx.jp (mx-mr1110) id 32O6AZKB009124
	(version=TLSv1.2 cipher=AES128-GCM-SHA256 bits=128 verify=NOT);
	Fri, 24 Mar 2023 15:10:35 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dBpgWxFnyUKl9TmAP4uydIhQ7mWpEiPFwidt/nPAKssJN8vwnFei8D1+4IYCTCUlnrBmf7C1Y4zlgeucia6KJd9In1xSEIvSns9u1ciNiHFPyVJ5ghgLec/o0triQJljlt2d1z08sKUZU694PYs/jyxvjjFq4I84HcIpFUPCM7uMz26t61r0DfTx85Zi3rjfZs/a3girfvLy+DNNsKIWbXuMswVfO6NjiY9Owyk5suIdaquGxlRzP4rBn6Qw1Ev+zfJxvPeF/p1Y4sYN8J+XpZF9TBra+KbGhm9PkFllozGp+sJsIViSwpPC+7Ck0yYM0iKCl0S65M/pXat+iFgwrw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=V2W/z04RtbPpHB1k2lqXkLD49n5Ry05neR9NFQ5xC8I=;
 b=oHBd/mrjrAaZsX93LGspkn9w7axHTHbMFb2C39IViqY0vMZn1aLBqjG+hnlKS6RNN4GXu1NJ59UhPup5idKdmFwRwBl5NY/lo9CwHFWFdhvpAIdIqsR2RA7RMwKtnEis2DGQ9ciLsNYeug2S03l5Q7jSkribZMsARheSgjzSgsY1xiqd1wJ5XdIr3FKzOr6ihjfpfmDaV0tj/S1e3KV4r0QfH/d0f/BqtvFnlWm2OvZj7NZseGw6CVWL0du5eL3SyzNtpcWCGyupmODY1KEaHqNC1OnXA1FiVN6iDWJG6C+qEpEoo5YM3Qul6WUqOJc28eSGZEg07K24Nf4Gdrp7bw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=toshiba.co.jp; dmarc=pass action=none
 header.from=toshiba.co.jp; dkim=pass header.d=toshiba.co.jp; arc=none
From: <nobuhiro1.iwamatsu@toshiba.co.jp>
To: <cip-dev@lists.cip-project.org>
CC: <pavel@denx.de>, <jan.kiszka@siemens.com>,
        <masami.ichikawa@cybertrust.co.jp>, <chris.paterson2@renesas.com>
Subject: RE: [cip-dev] [ANNOUNCE] Release v4.4.302-cip73
Thread-Topic: [cip-dev] [ANNOUNCE] Release v4.4.302-cip73
Thread-Index: AQHZVcWjEmp1f8HgNECXNSL8GNeTwa8Jge1g
Date: Fri, 24 Mar 2023 06:10:29 +0000
X-TSB-HOP2: ON
Message-ID: <TYWPR01MB94209AB476C8161596AA102892849@TYWPR01MB9420.jpnprd01.prod.outlook.com>
References: <1401403437.1593044.1678723493760@webmail.strato.com>
In-Reply-To: <1401403437.1593044.1678723493760@webmail.strato.com>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=toshiba.co.jp;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYWPR01MB9420:EE_|OSZPR01MB8718:EE_
x-ms-office365-filtering-correlation-id: ceaf0099-35c2-4534-0826-08db2c2e77c1
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: zsz9eOFuxRsNtUOd1xbHGHtq+IAxE65aTNK0p8T1h3b0Xv0/8ZKYi3qHm0RDXF3e0qXoZk4HsN3BbxovZCCdXJOgZI1uTTlUbx1f4Wijjk2Io96n5LzT9EzjwuXlzhE0h91SV2UiXlJ+SxdxTehxmftGryWjjRB4PCOt3cCsYAfBxlFcmPsa7HwVPjBSFhZNSkCu7vBFXtTDLIUFt4q6RcFn66k/Pnj7PsQe2k0NaFk/iKMKCvOv59aQMAmH97YUiaAz5vgze7b7gSdoiY3mDQaNNMjSCyT1k8F6r0fG1Aq0X7fqqayaof69CSOsWpTjXcT54uwJxT6RUPyS0EyCa9bwNlMfyYgylcUGDTzF+sG77B8P7LiLiJvIQNqhY/ozBqmzqXJKo1ZG3GQ/GGX+K7EUccLivPSKfGuER0f8E7fAMG5j/fDFk8gwCVXLwhN86GWxkVPaNA+f+b99YE6fmfpbGkuLpffqLeZL3cx7OJKlo5QVCuUZh+yp1lvFjHRDXdZhUYC5rZnTnb+TGxpCfbG1pSPXhgnCRcyDOSE5/tst9UA2RHA4fRDrH44oeChBYjjieF1TvpfnJnA5RClByRyqWIOJPv4YkqmWKP+NuXeCk73v4P1OGfW88GwCRh3ASxZKojnRA5ckL6zw18YoPjVpFi1oM6jaIwEvIaVfsysKDNeF/cY/2E1fKgUWmQ2NXWjQFm8Afv6wm6mXeC4LGRNONangr542d+DrT1Z8yL8=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYWPR01MB9420.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(376002)(39860400002)(136003)(366004)(396003)(346002)(451199018)(33656002)(38100700002)(4326008)(86362001)(6916009)(8676002)(66446008)(41300700001)(66946007)(66556008)(8936002)(52536014)(64756008)(76116006)(66476007)(71200400001)(966005)(316002)(54906003)(478600001)(7696005)(2906002)(5660300002)(38070700005)(55016003)(26005)(122000001)(9686003)(53546011)(6506007)(186003)(83380400001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?b3FaZllPT1dUVWFZSEY3bFMvWExnbUVPUmJFWGUvV2xzU0xlRk1VZzM3ajc2?=
 =?utf-8?B?bzZnUi9nL3BVaTFVVFlSMGZUVnI1T2hOdHdRZEZobGg2Qk12Zy9ReDVaU1BS?=
 =?utf-8?B?S3RSWDk5U3VabTJLb2s4cCsxZFhaYkVmT0hpZWp3c0dNYzkxak5aUU4yallG?=
 =?utf-8?B?d0RvcWRUQm52U0FWK0dJU0cwenloc0tEUDg4bnZjcWxSZkU1ejQwVzdncHhx?=
 =?utf-8?B?SXF0eUNHYVczY2tGMUs5TlVURllmdFB3cllHWVRDZGpjMzJXL29Cd3pCcllp?=
 =?utf-8?B?Uk15bU5oOWR3Q0lSTmtrTGFGTXJVbnNPcnNiWEcvL240czVXcURBUkdtUjhk?=
 =?utf-8?B?eEhRZ3pmdDlyRE5sbnVUY2lVMGZWY2dmVVNJdlQ2aU5yaHFMa1RZeStFNHhy?=
 =?utf-8?B?dWpzbU5BVGh5eWw4ZUZhMkhQK3dUWldOemtXaDM1R1QrZ055RFNQTUo2WmFp?=
 =?utf-8?B?V1FvUGsxVFBkTTNldW9kdHJRRXArSk83Z1VmL3NPYVc3UDdqMUlHc0dOdmVR?=
 =?utf-8?B?ZisvWXpFc3loMUNzZDVBekQrZTR6Z2QvdDdGNzFoaW56RSsrYm8vVklNMGZH?=
 =?utf-8?B?MEZCbUlFWW0rYkx6SDRzd29iNDMvVW8xRTM1dWdQRXdnWGlrcUZnaGRvNUF0?=
 =?utf-8?B?SFFQME5UYUVmTEc4L3ptSThOYlo4aEtCVEVaYkJDeU5seHcyRy9laUlWa0tu?=
 =?utf-8?B?dUhEalVCaUtkQkU3N0l2TzVzSFViMHpGbFVHVEg3dTJDcWplR3BnQmxoU3lE?=
 =?utf-8?B?aWlaTFk1aHpsNjg0N2h3TlVmSHplMzVrVk5rTzlTVW42Mm05U3dHdzZYZ0lw?=
 =?utf-8?B?YzZMTHpvTTJqZXV1cDFYcExYUk45Q1pITHVQSkxlZG8zRFozRFl5aDNaTm90?=
 =?utf-8?B?OGZJZllPWlIzdldJb3ZZK2trV09YZmoxbENicHRyeUVWbWcyRUFOQTdsOW9q?=
 =?utf-8?B?V2NyWEYwUVFNUEhaNDFKN2oxQ2hIQUpNdTFLZENiQUVhV3VZMUFtSUlTdisx?=
 =?utf-8?B?OW9ubExZOE9mQ0JEem5KblNFdkFVQ2ROZDVYaDFJRzRQSDlRbnhZeWZ4Yldt?=
 =?utf-8?B?NEtYK25VZG90T0NrRjBDTk8vK3V3VU1DWjlLZkUrRXJqWWxvRU05YnZoS3hl?=
 =?utf-8?B?NXNJS2x4Z1RCYUw2c0ZXb0xaeS95Q3VTdjRGa1lFNVpZVmdNY1k1WnY4QjFT?=
 =?utf-8?B?eUNmMHdnRlJMWE1WT3BaN3BRM3NrbXo0ZXpyQUtyMzZpbkl5MXU0SVZPUElQ?=
 =?utf-8?B?SmNxQytpR20rM01YTEZCZWM3bE4yc0VoVDNRZXJaYkhkUXBsL2NvRDEvQUxi?=
 =?utf-8?B?WFpRbWJaRUZVRWZaTlB2b3QyT05JVkJXU0JraWFsVFNleXM2VUZJV000R0Rn?=
 =?utf-8?B?cktlRW9RZ3BNczhvN3d6ZmxTMHVmaGVmbngydjRERHMyTzdtQkQzcUlqSzcx?=
 =?utf-8?B?clh0SG9OVjJhcVg4VTU2V0pNcjlQR3p2UnhiWTIxWGJTU3dOb0V5WGhhckhn?=
 =?utf-8?B?VVJiK3RXY2VsUXdIRG5jdjR5RkxnRWxQdWdINnN0WE50NnpsMUgzK1dtNkFG?=
 =?utf-8?B?cllycHI4YUR6NFVsQTA3V3BYN2M2Vk5ZSWs3d2p6VW0rcU5IYXViOFQ1eEgx?=
 =?utf-8?B?KzVKNjVDN1lMYStCTFpqaXVMcHgzQTMrcC9iMDBFcnB3VCtJeTl2bXdFWW5m?=
 =?utf-8?B?MHZDYmh5VU9iWEthZzRwR2l3RU1QRGxkT3FvbDBtbjE0TGh4SUhLVWZWay9W?=
 =?utf-8?B?a3lvbjJMaXF2L1lNM3NobG9nKzBqcmtzZTNrTlErRUxGc0M3WThvN1dLOXhz?=
 =?utf-8?B?TjFVaUM3dlFZajcxMjJuQ1VsN0Y4djQ2SmxYQ0k4S281ZUFXekMvYUNCdHFk?=
 =?utf-8?B?cDNyM3NhVHNrQ25ObjAvbEZkbnNwUUhUVmhzY2hTREdhemtJL1JhWkF6QlBL?=
 =?utf-8?B?cmh2ZnB6c2NtRUovQnpKYUM5cGRDdmxPZW9FUmszNmo2dUVUeFJ5Ylplbzda?=
 =?utf-8?B?Rmp2K1MrejgvUTR1bXdNWnRRaWs5djZIVTBvUkNLL05EclVJT09OT3dycW1B?=
 =?utf-8?B?YzVzenJNcXZtclNXdUNvZm53aWRES3IyL2FqNThnOG5oQ3QzSGQzNXdBK0FF?=
 =?utf-8?B?dm1Wc2V2RnJxbTZUTWRuOEVlUWlzejhMa1hPLzJGRWI5S1ROL2d6RG15Tjg2?=
 =?utf-8?B?T3c9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYWPR01MB9420.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ceaf0099-35c2-4534-0826-08db2c2e77c1
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Mar 2023 06:10:29.1989
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f109924e-fb71-4ba0-b2cc-65dcdf6fbe4f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: KFD03ZBKut0IxtklkZOMC99tM99tXTkXWsUPPatiOKiZm3QZ64cYy0K0CBGG+1W4eaDMExoxgNw302s23xWTapYIF12TPMHrT76OinUKWCsT6w/9Pw8HbWyMaAP3Gxk1
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSZPR01MB8718
X-OriginatorOrg: toshiba.co.jp
MSSCP.TransferMailToMossAgent: 103
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 24 Mar 2023 06:10:55 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/11104

SGkgVWxpLA0KDQpDb3VsZCB5b3UgdXBkYXRlIGxpbnV4LTQuNC55LWNpcC1yZWJhc2UgdHJlZT8N
Cmh0dHBzOi8vZ2l0Lmtlcm5lbC5vcmcvcHViL3NjbS9saW51eC9rZXJuZWwvZ2l0L2NpcC9saW51
eC1jaXAuZ2l0L2xvZy8/aD1saW51eC00LjQueS1jaXAtcmViYXNlDQoNClRoaXMgdHJlZSBtYW5h
Z2VzIHRoZSAtY2lwIHRyZWUgc291cmNlIGNvZGUgcmViYXNlZCBmcm9tIHY0LjQueS4gVGhpcyB0
aW1lIHdlIG5lZWQgdG8gcmViYXNlIGZyb20gdjQuNC1zdDM4Lg0KDQpCZXN0IHJlZ2FyZHMsDQog
IE5vYnVoaXJvDQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogY2lwLWRl
dkBsaXN0cy5jaXAtcHJvamVjdC5vcmcgPGNpcC1kZXZAbGlzdHMuY2lwLXByb2plY3Qub3JnPiBP
bg0KPiBCZWhhbGYgT2YgVWxyaWNoIEhlY2h0DQo+IFNlbnQ6IFR1ZXNkYXksIE1hcmNoIDE0LCAy
MDIzIDE6MDUgQU0NCj4gVG86IGNpcC1kZXZAbGlzdHMuY2lwLXByb2plY3Qub3JnDQo+IENjOiBw
YXZlbEBkZW54LmRlOyBqYW4ua2lzemthQHNpZW1lbnMuY29tOw0KPiBtYXNhbWkuaWNoaWthd2FA
Y3liZXJ0cnVzdC5jby5qcDsgY2hyaXMucGF0ZXJzb24yQHJlbmVzYXMuY29tOyBpd2FtYXRzdQ0K
PiBub2J1aGlybyjlsqnmnb4g5L+h5rSLIOKWoe+8s++8t++8o+KXr++8oe+8o++8tCkNCj4gPG5v
YnVoaXJvMS5pd2FtYXRzdUB0b3NoaWJhLmNvLmpwPg0KPiBTdWJqZWN0OiBbY2lwLWRldl0gW0FO
Tk9VTkNFXSBSZWxlYXNlIHY0LjQuMzAyLWNpcDczDQo+IA0KPiBbQU5OT1VOQ0VdIFJlbGVhc2Ug
djQuNC4zMDItY2lwNzMNCj4gDQo+IEhpLA0KPiANCj4gdGhlIENJUCBrZXJuZWwgdGVhbSBoYXMg
cmVsZWFzZWQgTGludXgga2VybmVsIHY0LjQuMzAyLWNpcDczLiBUaGUNCj4gbGludXgtNC40Lnkt
Y2lwIHRyZWUncyBiYXNlIHZlcnNpb24gaGFzIGJlZW4gdXBkYXRlZCB0byB2NC40LXN0MzguDQo+
IA0KPiBZb3UgY2FuIGdldCB0aGlzIHJlbGVhc2UgdmlhIHRoZSBnaXQgdHJlZSBhdDoNCj4gDQo+
ICAgdjQuNC4zMDItY2lwNzM6DQo+ICAgICByZXBvc2l0b3J5Og0KPiAgICAgICBodHRwczovL2dp
dC5rZXJuZWwub3JnL3B1Yi9zY20vbGludXgva2VybmVsL2dpdC9jaXAvbGludXgtY2lwLmdpdA0K
PiAgICAgYnJhbmNoOg0KPiAgICAgICBsaW51eC00LjQueS1jaXANCj4gICAgIGNvbW1pdCBoYXNo
Og0KPiAgICAgICBiNThlMThhNjdhYzE5MmM1OTVhY2RhZjY3YzJlNjY2YmYwNDMzNzg3DQo+ICAg
ICBGaXhlZCBDVkVzOg0KPiAgICAgICBDVkUtMjAyMi00NzkyOTogSW4gdGhlIExpbnV4IGtlcm5l
bCBiZWZvcmUgNi4xLjYsIGEgTlVMTCBwb2ludGVyDQo+IGRlcmVmZXJlbmNlIGJ1ZyBpbiB0aGUg
dHJhZmZpYyBjb250cm9sIHN1YnN5c3RlbSBhbGxvd3MgYW4gdW5wcml2aWxlZ2VkIHVzZXIgdG8N
Cj4gdHJpZ2dlciBhIGRlbmlhbCBvZiBzZXJ2aWNlIChzeXN0ZW0gY3Jhc2gpIHZpYSBhIGNyYWZ0
ZWQgdHJhZmZpYyBjb250cm9sDQo+IGNvbmZpZ3VyYXRpb24gdGhhdCBpcyBzZXQgdXAgd2l0aCAi
dGMgcWRpc2MiIGFuZCAidGMgY2xhc3MiIGNvbW1hbmRzLiBUaGlzDQo+IGFmZmVjdHMgcWRpc2Nf
Z3JhZnQgaW4gbmV0L3NjaGVkL3NjaF9hcGkuYy4NCj4gICAgICAgQ1ZFLTIwMjMtMDA0NTogQnlw
YXNzaW5nIFNwZWN0cmUtQlRJIFVzZXIgU3BhY2UgTWl0aWdhdGlvbnMNCj4gICAgICAgQ1ZFLTIw
MjMtMDM5NDogaXB2NjogcmF3OiBEZWR1Y3QgZXh0ZW5zaW9uIGhlYWRlciBsZW5ndGggaW4NCj4g
cmF3djZfcHVzaF9wZW5kaW5nX2ZyYW1lcw0KPiAgICAgICBDVkUtMjAyMy0xMDczOiBISUQ6IGNo
ZWNrIGVtcHR5IHJlcG9ydF9saXN0IGluIGhpZF92YWxpZGF0ZV92YWx1ZXMoKQ0KPiAgICAgICBD
VkUtMjAyMy0xMDc0OiBzY3RwOiBmYWlsIGlmIG5vIGJvdW5kIGFkZHJlc3NlcyBjYW4gYmUgdXNl
ZCBmb3IgYSBnaXZlbg0KPiBzY29wZQ0KPiAgICAgICBDVkUtMjAyMy0yMzQ1NTogbmV0OiBzY2hl
ZDogYXRtOiBkb250IGludGVwcmV0IGNscyByZXN1bHRzIHdoZW4gYXNrZWQNCj4gdG8gZHJvcA0K
PiAgICAgICBDVkUtMjAyMy0yMzU1OTogcm5kaXNfd2xhbjogUHJldmVudCBidWZmZXIgb3ZlcmZs
b3cgaW4NCj4gcm5kaXNfcXVlcnlfb2lkDQo+ICAgICAgIENWRS0yMDIzLTI2NTQ1OiBuZXQ6IG1w
bHM6IGZpeCBzdGFsZSBwb2ludGVyIGlmIGFsbG9jYXRpb24gZmFpbHMgZHVyaW5nDQo+IGRldmlj
ZSByZW5hbWUNCj4gDQo+IEJlc3QgcmVnYXJkcywNCj4gVWxyaWNoIEhlY2h0DQo=


