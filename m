Return-Path: <nobuhiro1.iwamatsu@toshiba.co.jp>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 988F3CD494A
	for <webhook@archiver.kernel.org>; Thu, 21 Sep 2023 04:01:32 +0000 (UTC)
Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.134])
 by mx.groups.io with SMTP id smtpd.web11.8669.1695268889175572434
 for <cip-dev@lists.cip-project.org>;
 Wed, 20 Sep 2023 21:01:29 -0700
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: toshiba.co.jp, ip: 210.130.202.134, mailfrom: nobuhiro1.iwamatsu@toshiba.co.jp)
Received: by mo-csw.securemx.jp (mx-mo-csw1800) id 38L414i1761401; Thu, 21 Sep 2023 13:01:04 +0900
X-Iguazu-Qid: 2yAa6hjhDF8k9iUcPj
X-Iguazu-QSIG: v=2; s=0; t=1695268864; q=2yAa6hjhDF8k9iUcPj; m=BDz+VsMpaf00TFxA5I+0iECJvPqPzpIU2SSHL5mVAsc=
Received: from imx2-a.toshiba.co.jp (imx2-a.toshiba.co.jp [106.186.93.35])
	by relay.securemx.jp (mx-mr1801) id 38L412iD855020
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
	Thu, 21 Sep 2023 13:01:02 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mXowSaiZRd6M671iJkTtRtfr9EtwJqVmWMcnLGZY+zcIGTG1fMyhL91tzY2OOWkDXsMNbUCGWHBtDQSYIk3Ma1O1FHARSmtFnkytslo903L2IJhLG8Pe8DYCl3o2es5wCxG6TSb9UsA9c6QNXrf+cXlVpyWvb8rGU962x1qYmWRMJGmfv0MbnkznnrIeuaxC2JeZ8FUrLZVWp10Yb4e9XmNyUZySM+FDW44WCprK3vDN5kkhZGY0Sx0YxIkMdnYpKnPgQmUfboD991ZmDqxHdPYHZ3ZFYK/KKYIeQcXHSuyR2Zt/vDBtTvaQtthHhaYpSoZ31GU9mam5RZgvpGrBEQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5c/xxkU8pEM6jcvAFXVLLdcZ0ExtkMB76mJZg4HmVFc=;
 b=RN62Ym+nRNypa8x9HRQ5nGYx6hknnNKjgkKIUMlrBEDTLr3J06yvCOhZbAm5T0LXsgtYs74AfIkxpEkZ/orimKkufXSNGfSrMlnlSesrD+S/IV/bZ4ClC07ZhJL4ivozLpYsm3nrqOR34ckVOnddDf7ezhjPkG4Wkhe0zHyMw74dIBWk7qIWkJNIxNGTLAi4pBX5ND9wIwI9nCabqxWBq+eGVfjCmR7op1388Hq6UMd1Dk3uiJPX1FvaujVlBxO+RPFB2ygnLcsNnS+Iz63ZaLIE6evAZcCvOjdmPrnZdejzJmK93pOo25ynnhtAl8W0B1e+sJRBqLWQMXbQiZOKIw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=toshiba.co.jp; dmarc=pass action=none
 header.from=toshiba.co.jp; dkim=pass header.d=toshiba.co.jp; arc=none
From: <nobuhiro1.iwamatsu@toshiba.co.jp>
To: <cip-dev@lists.cip-project.org>
CC: <pavel@denx.de>, <uli@fpond.eu>, <masami.ichikawa@cybertrust.co.jp>,
        <Chris.Paterson2@renesas.com>
Subject: RE: [cip-dev] [ANNOUNCE] Release v5.10.194-cip39
Thread-Topic: [cip-dev] [ANNOUNCE] Release v5.10.194-cip39
Thread-Index: Adnq8bl7whuogWpjQ6GDs4st3ouSugAkxliAAABYEQAABbGSoAAoxh4w
Date: Thu, 21 Sep 2023 04:01:00 +0000
X-TSB-HOP2: ON
Message-ID: 
 <TYWPR01MB942001DD9BDCEFD2CC653CC192F8A@TYWPR01MB9420.jpnprd01.prod.outlook.com>
References: 
 <TYWPR01MB9420C4F2D1A4D50470E0E5CA92FAA@TYWPR01MB9420.jpnprd01.prod.outlook.com>
 <0de9f4af-bf37-4bf8-bf5c-28b2b6d7fda9@siemens.com>
 <9f3cfa5f-d448-4df3-a2df-d7d20af9b120@siemens.com>
 <TYWPR01MB942009F12C0F5B1ACFBBC36A92F9A@TYWPR01MB9420.jpnprd01.prod.outlook.com>
In-Reply-To: 
 <TYWPR01MB942009F12C0F5B1ACFBBC36A92F9A@TYWPR01MB9420.jpnprd01.prod.outlook.com>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=toshiba.co.jp;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYWPR01MB9420:EE_|OSZPR01MB9280:EE_
x-ms-office365-filtering-correlation-id: 5f3795c6-e49f-4ca8-314f-08dbba575ddf
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 F7AavbYcBxbWxHlfkDP8NvqyooQlnB3++LYSUqpcxfobC/sJTR2jExvmmzfInZuc+2lhUArNXbToCJTbLpJO3Y4oVPLKU9tgn4dwZ23+4FOhhKalqvK4XivCRRXt8BD0bjephBjqEKyJxOkIShy95/8cY8SvHV97ABN+u0dwE5hV2t84XpYYFMDhsdS9STNsfBtlvjBBSYIrgxT1jUzdze+GAVbZtx/c4ZWqMUrYIuqr2RFZAzC6JAIL6hCY0ZD02UM1XWEi1CmKq3vUe13FPI4EOjTUJ3P1F4RlEjm+W5wumczbxmi7PsgK1GsQyDvTHB1e8TvC/oB1ia+pqBqQfZk2OqsKKTUJcO93hjr0qaxM0uET2MVWmC4OBBhf0ieabBDrKV5A9zGk4XLBCo4lUt242YXSAsb8byJ9Fzmb/H/fDWpiRzHcG2hOaRF5/0rYZt/pjaOZJ3aQUqRw6GiM8M0YoJ91mV7dcXZu25+JjPsBnPlZvx48BoGJM6b989iXCkswytmojo0k4dwouUcjZiGaUb6Nr48SyGuSIWDeswUQMC1U8vm8NW6Pua6pP5Vhwi2Oonds9oSef6FWb2v4AXxTbGbM3C881B/QDsiykMg=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYWPR01MB9420.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(366004)(346002)(396003)(39860400002)(136003)(1800799009)(451199024)(186009)(54906003)(8676002)(71200400001)(4326008)(66446008)(66556008)(64756008)(66946007)(76116006)(33656002)(966005)(478600001)(5660300002)(66476007)(6916009)(316002)(86362001)(41300700001)(38100700002)(52536014)(8936002)(9686003)(6506007)(7696005)(53546011)(122000001)(2906002)(38070700005)(55016003)(83380400001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?utf-8?B?emYxY2FRMWJQd1l2VWE4cTJLd1I2V096eUFsR1RzNGJUakpTRk1BNjI2WDRj?=
 =?utf-8?B?NXhRL2RGY0dTMlpCRG9Wd1g5RWR6WlZEYmpZMjdVVVIrQXZOOFM2MHNZcndQ?=
 =?utf-8?B?emRkVmwyL1I4WmhET2lQelZTUmxnakRmeE55ZXNCYlE3UG5GT1MzOXZkUlhi?=
 =?utf-8?B?S1M4OTNQSWg1UjJxUmZtQWdNQS8zdDVPNGg0bFpKWmRGcStoM1RCOHJVK1V2?=
 =?utf-8?B?dldCQWhKbVc4OVArNnd3Zm42QkJNRnVJcVRnQTBtYXVWT1VETjZvTzlVb1Nu?=
 =?utf-8?B?Mko1YVFSN0dDOTFBU2ZaS1cxSXh3d1hic1ZvRTJNWm9xL3ZLQksxSWhYWFMr?=
 =?utf-8?B?QzdHLzE5U2JBTnVramZCaThUSFh2T3VJOW1LejJyT1d2K05jaGNBdkJsWmpG?=
 =?utf-8?B?QjgyUkx1QzdqYTgzaVRMVGsvZUs0cEcwaDlGNDFjdCtGMG1GNUkyMy9GcUJw?=
 =?utf-8?B?QWFXR3BtQ3Z2Y1BrcTFuUTZueTJ3TGpWcU80UUs1RktwLzZ0TW5Wc2QyTEV5?=
 =?utf-8?B?SnU0Sjd0V0IwWkFPbVVHWndQQVZBanJ0dUk5amNETXpyL2tOejkyc0tzcnJS?=
 =?utf-8?B?RXAvbDRxY1MzTERzelBtcUpYbitOb1ZCNENaQ0lYc3Zlb0xYd1hINGlsbnQv?=
 =?utf-8?B?d1ovL2czNHNORlZuZzMrVVV6Y3ZuV3VVcGkyQ2NYLzZ2M2c4Qk12Z1M0OHlW?=
 =?utf-8?B?V0F2SU9EZTNpSkVNclZtbHlib2wrT1ZMdDNoclZtMEcyR0FuMkFKcG1mZzFY?=
 =?utf-8?B?ZW9PQzF2U2IyT01jT2ZFbUwxcHV0QXV1RmthUmNmMklDY0NyZ1cvMDZqaHB1?=
 =?utf-8?B?TXhzRDhpTGNZNnRFUDg3T3F0VUxISXIvNjRrSUNOL29YK0N6MmpGeDhGZGRs?=
 =?utf-8?B?OEx1bFhRRDFnOTN5WjR6bHRPa3REcTJJeTlEMXdORGhFbzhLRTVUSWxQZlJi?=
 =?utf-8?B?YmV6WlVwanlFQmY3dVVjOGdnTzIzdnlPb2RYcHRlTFRpRnQ0RUdNV3UxQmxN?=
 =?utf-8?B?WHEzOStLNGkzQSs1a2xDeXNBd0psa09yd0czRWRINjZCSWZGVlp1SHZSRStN?=
 =?utf-8?B?WXFuY0ZFL01ac0Nzb1hrcm5tR3d2Zi9kTGU5Q0hkc0l3YUozL3F0VVdmZFZu?=
 =?utf-8?B?ajZzWkY3RC9XMEUyb0owY0ZNTjJUTmxtV0czNTZudDhDNU9EQ2JvUHBQdGgx?=
 =?utf-8?B?VDU1NTNhQ283NlNGUExsYlRNMjU1SXNpNjB6V2cvelo0aWlaQkRtdHZZS1FF?=
 =?utf-8?B?YVgrMmUvRHltcjFTN3cxWm9ZcHBucStLbHpWSFZuVkF4Zm5DbENKc2tGZ0Va?=
 =?utf-8?B?U0RKdFQ3VzVUNExFVGpRY1RDUzBGZFRqREYyeW5oM3g2ZHVTWUl3SlJ5dWtU?=
 =?utf-8?B?Tll5Qk9Mc0lpN0pxaU9JdEVpbzBNTFpiR3BRM3JjeDYreTdRT2dsSHdzR2lv?=
 =?utf-8?B?bkVYQ3VjVk8wUjY1QTk5Zk5ST240aXhNbFY5WUZlNkp6QWU3VWxxc2dtR1Mr?=
 =?utf-8?B?WWVFeDR0L0pCU2pNRmtKRDdWeERlZmFYSWg5K3F1UlBDWDJPWkNBV1o3UGYw?=
 =?utf-8?B?Mk5ZUXcvVng0WHl2NUNtM2ZieThISFB1MEt4SWhablRFM1R2QUlnK2ZoWDB6?=
 =?utf-8?B?NUQzSzQ2enFIWDl5U2VSU3hBQlNRZHd5WWxFYmYveEptUEt1SytlMml6UHhG?=
 =?utf-8?B?elBNd3ViSWs2T1ltTWp4eFBGNnZ6TUdvWkNEOTc4TnFHTXcrYUhFTXUweHRl?=
 =?utf-8?B?VEtKbythN3JUcS82YnNIc1RuRmFoclMyLzBOT3BrMW9YeDRWemRDODEzc1Ro?=
 =?utf-8?B?K1k1N1BQNVowVUhuenJvRmFmTGU0a0ZtUnJVQUxNdlBGdjA1WGRxOG44ekxj?=
 =?utf-8?B?UVk4OEhnZWcySU1TT2QzZ2c5eVlMbWlCR2hlSVZHdGtqOTgzRnFkczhteGdK?=
 =?utf-8?B?UWpVUlVWUjhjV3NXQjZCVmxLMTNscnYxV2pHQ1lGNFdRSDdkK3pIdGRleS80?=
 =?utf-8?B?bHpiVEZQTmdLdmFtZ243cFJacTFYcjFrUmo1clVWc2dzODZvQ0U4VzFNY2pk?=
 =?utf-8?B?eVpFWFdPN1FNZWZkYXNjeFFiRFN4NjIvZW5XK1VsaXhxcGJlZVRaNjRlQUFU?=
 =?utf-8?B?RVBSSnlnd043cDlINm4yMVMxNFUyUk9vOTFlYWFhTzI1aEJ1Ulpsc3Q2Vk9n?=
 =?utf-8?B?c04xTlRYUFFDVm5nTnlnK3lGRjE2NzN2Nlppa3czMWNXa1c1NEhDZlczbkRs?=
 =?utf-8?B?UFByUG1zQktCN2hES3ZkbnlrR3ZRPT0=?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: toshiba.co.jp
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYWPR01MB9420.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5f3795c6-e49f-4ca8-314f-08dbba575ddf
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Sep 2023 04:01:00.2412
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f109924e-fb71-4ba0-b2cc-65dcdf6fbe4f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: QwC1yU1sCxu9vXwmJA9TEnAlyC45wditoOTkbXNjY4bvtJil0kzZh8ZDzrylCCdYj3ZsPCIldcmLyIShEQyZOLga2rH7evz3uZgp9f0sX1qN04Nx6gNKt5QiXgkkoJPM
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSZPR01MB9280
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 21 Sep 2023 04:01:32 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/13183

SGkgYWxsLA0KDQo+ID4gSnVzdCByZWZyZXNoZWQNCj4gPiBodHRwczovL21pcnJvcnMuZWRnZS5r
ZXJuZWwub3JnL3B1Yi9saW51eC9rZXJuZWwvcHJvamVjdHMvY2lwLywgYW5kIGl0DQo+ID4gc2Vl
bXMgYSBtYXNzIHVwbG9hZCBpcyBvbiBpdHMgd2F5IC0gdGhhbmtzIGEgbG90IQ0KPiA+DQo+ID4g
Tm93IHRoYXQgdGhlIGZvbGRlciBpcyBmaWxsaW5nOiBTaG91bGQgYW5kIGNhbiB3ZSBzdHJ1Y3R1
cmUgaXQgaW4NCj4gPiBzdWJkaXJzIGFjY29yZGluZyB0byB0aGUgbWFqb3Iga2VybmVsIHZlcnNp
b25zPw0KPiANCj4gSW5kZWVkLCBJJ2xsIGludmVzdGlnYXRlIGFib3V0IGl0Lg0KDQpUaGlzIGlz
c3VlIGhhcyBiZWVuIGZpeGVkLg0KaHR0cHM6Ly9taXJyb3JzLmVkZ2Uua2VybmVsLm9yZy9wdWIv
bGludXgva2VybmVsL3Byb2plY3RzL2NpcC8NCg0KQmVzdCByZWdhcmRzLA0KICBOb2J1aGlvDQoN
Cj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogaXdhbWF0c3Ugbm9idWhpcm8o
5bKp5p2+IOS/oea0iyDil4vvvKTvvKnvvLTvvKPilqHvvKTvvKnvvLTil4vvvK/vvLPvvLQpDQo+
IFNlbnQ6IFdlZG5lc2RheSwgU2VwdGVtYmVyIDIwLCAyMDIzIDU6MzQgUE0NCj4gVG86IGNpcC1k
ZXZAbGlzdHMuY2lwLXByb2plY3Qub3JnDQo+IENjOiBwYXZlbEBkZW54LmRlOyB1bGlAZnBvbmQu
ZXU7IG1hc2FtaS5pY2hpa2F3YUBjeWJlcnRydXN0LmNvLmpwOw0KPiBDaHJpcy5QYXRlcnNvbjJA
cmVuZXNhcy5jb20NCj4gU3ViamVjdDogUkU6IFtjaXAtZGV2XSBbQU5OT1VOQ0VdIFJlbGVhc2Ug
djUuMTAuMTk0LWNpcDM5DQo+IA0KPiBIaSwNCj4gDQo+ID4gPiBQbGVhc2UgZG9uJ3QgZm9yZ2V0
IHRvIGZlZWQNCj4gPiA+IGh0dHBzOi8vY2RuLmtlcm5lbC5vcmcvcHViL2xpbnV4L2tlcm5lbC9w
cm9qZWN0cy9jaXAvLiBJJ20gc2VlaW5nDQo+ID4gPiBtb3JlIHJlbGVhc2VzIHRoZXJlLCBidXQg
bm90IHlldCA1LjEwLCBhbmQgdGhlcmUgYXJlIG1vcmUgZ2Fwcy4gV2UNCj4gPiA+IHJlYWxseSBu
ZWVkIHRvIHN3aXRjaCBvdXIgQ0lzIHRvIHRoaXMgc291cmNlIEFTQVAuDQo+ID4gPg0KPiA+DQo+
ID4gSnVzdCByZWZyZXNoZWQNCj4gPiBodHRwczovL21pcnJvcnMuZWRnZS5rZXJuZWwub3JnL3B1
Yi9saW51eC9rZXJuZWwvcHJvamVjdHMvY2lwLywgYW5kIGl0DQo+ID4gc2VlbXMgYSBtYXNzIHVw
bG9hZCBpcyBvbiBpdHMgd2F5IC0gdGhhbmtzIGEgbG90IQ0KPiA+DQo+ID4gTm93IHRoYXQgdGhl
IGZvbGRlciBpcyBmaWxsaW5nOiBTaG91bGQgYW5kIGNhbiB3ZSBzdHJ1Y3R1cmUgaXQgaW4NCj4g
PiBzdWJkaXJzIGFjY29yZGluZyB0byB0aGUgbWFqb3Iga2VybmVsIHZlcnNpb25zPw0KPiANCj4g
SW5kZWVkLCBJJ2xsIGludmVzdGlnYXRlIGFib3V0IGl0Lg0KPiANCj4gQmVzdCByZWdhcmRzLA0K
PiAgIE5vYnVoaXJvDQo=


