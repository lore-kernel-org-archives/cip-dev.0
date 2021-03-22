Return-Path: <SRS0=0Ofz=IU=lists.cip-project.org=bounce+64572+6304+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3EEFC433E2
	for <cip-dev@archiver.kernel.org>; Mon, 22 Mar 2021 05:58:11 +0000 (UTC)
Received: from mail02.groups.io (mail02.groups.io [66.175.222.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 29D426196B
	for <cip-dev@archiver.kernel.org>; Mon, 22 Mar 2021 05:58:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 29D426196B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=toshiba.co.jp
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+6304+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id AmV9YY4521723xrUqOrqOAzW; Sun, 21 Mar 2021 22:58:10 -0700
X-Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.158])
 by mx.groups.io with SMTP id smtpd.web09.8879.1616392687972228111
 for <cip-dev@lists.cip-project.org>;
 Sun, 21 Mar 2021 22:58:10 -0700
X-Received: by mo-csw.securemx.jp (mx-mo-csw1116) id 12M5w4aJ017287; Mon, 22 Mar 2021 14:58:04 +0900
X-Iguazu-Qid: 2wGqpfOl1DPfvJ5DCz
X-Iguazu-QSIG: v=2; s=0; t=1616392684; q=2wGqpfOl1DPfvJ5DCz; m=w9Bmbl3Daq1Qd77YltTZfA/moGHdHDL49ZMNg5B/9Z8=
X-Received: from imx2-a.toshiba.co.jp (imx2-a.toshiba.co.jp [106.186.93.35])
	by relay.securemx.jp (mx-mr1112) id 12M5w3fS018490
	(version=TLSv1.2 cipher=AES128-GCM-SHA256 bits=128 verify=NOT);
	Mon, 22 Mar 2021 14:58:03 +0900
X-Received: from enc01.toshiba.co.jp (enc01.toshiba.co.jp [106.186.93.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by imx2-a.toshiba.co.jp (Postfix) with ESMTPS id 26A6D1000B3;
	Mon, 22 Mar 2021 14:58:03 +0900 (JST)
X-Received: from hop001.toshiba.co.jp ([133.199.164.63])
	by enc01.toshiba.co.jp  with ESMTP id 12M5w2iJ001108;
	Mon, 22 Mar 2021 14:58:03 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iaasoJvIbrjbgjTrY124xgMJvE+3m5mp6suLShMeARTA2/pWTs081KTWRBWlI8NQdaUkqEpUXOmRqInDe4l+/ei++INTQJABG30+BtlMNak4PpO9Zuib9/CZdYFkMQF62T/1XYLPWGmaM52fDqcGSdIPmTvFPlQx7xkRqX6Xqwbrhzr+QAMm+roQCGpXlxS4CYB+69jpXKdhUiFi4xwnc9f97yLUVRZ6O0coH+Nhx7aB9FbPt8UZJ0UuRNsq4EQLpSbCBPjf8RFZ/Tkl55R1ihKgOPD0f803ptnvYq17rO575Rm/kFQ/x/pmJ02Bx36tVSkXRfrgm7zKWh9+Mhy4vw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FmeMVM0YmXH81t1PDZ8IoPlI/cIOrr7efbbaZYKLwuE=;
 b=XZrHFz9Yu9Kwx2Y4LSpupuHLbYY6lPff4n34nt4VlvZwMk5qXtBYQo8TfLTEVjx67AWJ7gZsXpsX1Yj1UZz4VMo3DvczyiiHJa6aHIEKkwXpPCDby4WGWCsR9WjdQkH2JCDHCtSFLsqRXGF7X8S+Ezfbav7Sw+Sq38ShYMDdnVkwNFIV/Kk8xtOId+CocztnCUb7fnT1HwJfGb68j6aAo+x6xOegxeXt8Ls5JD8ugViHjamV+yIpW0A+lJ0Mlprp3OvX483AtM3KO0gxlMKns3naEaa+dJRsuoCKSzoQqmx9Fhw1iG3EO1g+Mr3UrQ/Hbj3lS4vQKHVc+zCQAQzcrA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=toshiba.co.jp; dmarc=pass action=none
 header.from=toshiba.co.jp; dkim=pass header.d=toshiba.co.jp; arc=none
From: "Nobuhiro Iwamatsu" <nobuhiro1.iwamatsu@toshiba.co.jp>
To: <cip-dev@lists.cip-project.org>, <cip-members@lists.cip-project.org>
Subject: Re: [cip-dev] CIP LAVA maintenance
Thread-Topic: [cip-dev] CIP LAVA maintenance
Thread-Index: AdcbzkOQKf6QAN7RRByXfiJr+ZwsYQAv/28wAJR0VeA=
Date: Mon, 22 Mar 2021 05:58:00 +0000
X-TSB-HOP: ON
Message-ID: <OSBPR01MB2983C40C41891B52F113128B92659@OSBPR01MB2983.jpnprd01.prod.outlook.com>
References: <166D61BDF351CC05.5206@lists.cip-project.org>
 <OSBPR01MB2392E14F337E62A92502D5B1B7689@OSBPR01MB2392.jpnprd01.prod.outlook.com>
In-Reply-To: <OSBPR01MB2392E14F337E62A92502D5B1B7689@OSBPR01MB2392.jpnprd01.prod.outlook.com>
Accept-Language: ja-JP, en-US
x-originating-ip: [103.91.184.1]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 0619983c-743b-4235-79cb-08d8ecf77349
x-ms-traffictypediagnostic: OSAPR01MB2627:
x-microsoft-antispam-prvs: <OSAPR01MB26278276486DBD6674F22AED92659@OSAPR01MB2627.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6108;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: FwUwxkpJdSHGiD3THougf+ac8r3fH7JLmZl/64AirXl9H5wDJl2tPJNpNEjl3xf1S+QY8s3yYgXfPmzAeLftC0LGZSbI/orPSPEhA5ua0iZ8RIGgW/AX5LZe0fLHFT9jeeA/oVf+DvKLtPyisnlPPkkbkwgZhbJ2lGHYFhpLx3uozt5QapL4FC1D6FSc+rG6BUGyJUFgFQOSfXaZiTMaAzYyjUkkZwYcNuHP1zODFgnMV/im05ToPIOTY0EUpw/1YfV1UL+iBNbSSiVu5WLZNOuHHrRIgT7OscMfmxD/b7WVKLhHXh/QjZ8ITtEi815l2SRKPFsa95+ryZtu/vRf6Pg4JnZMWLmmWrI0EKbOkIcxNcyzUzNQR+XJRLZfvQ1kFgC4O6iIrq/unV08YP+2pwDy17tBb6T85b5h5LXa3s4Z81AIDuEKNHEd9PzwQzkD3KwH/gogY3YSR0p7d75qkEc2UL/cLqAbV9GhXow4sTV8yjpCZqQMQXyyLoGPtGP1ZkRDHXInca9Q9QwNVXjpYz2TERNQXFqqfWas2KYi9RB3Jo1rItzZwbRprM66gMe+LdRozwob9J6dLFaHHzroOd7QiiZvWk/XfiWAyDrtAPZ2S7XZmAVzX9acDqHnKCDDKHPkkTja+jqqVDEuMlnscF9fpMxETxIcvQyIR4Or/g8=
x-ms-exchange-antispam-messagedata: =?utf-8?B?UU5DOWxYd1R0T1doRVFhbkxwd3Nld01XK1VoTGpxWVlydWkxQmdTREgwQW43?=
 =?utf-8?B?VVpCaTBoTUFVQlFPS2M4NFhFSkl5alB5MzhPL1hKajIxU0dSa3JqYmUzRnJ0?=
 =?utf-8?B?UXB2ME9SM29IRXhrOUdHc1gxaFRQQklWb1M2K2srRWd0VlVQRkZEUTJ5cjBM?=
 =?utf-8?B?TlJCYnNTdDUxekFTUVYzbjU4T2s0eUdJTWN3bUt2cnpMd0lkOU9scDFkNFdu?=
 =?utf-8?B?T0pWbnRJNkdYZkxFaHVZZURxUllTVjVaeGRZT1FyNmEvdlJFRXZLbjVqOXpQ?=
 =?utf-8?B?VUNINEFsK2tmZW5zbUlMRXFpcEprRDFTVUJnRnZTN3hpRkVaYVlaNjNleUlI?=
 =?utf-8?B?djl6YVV5L3EvQXFveHlxVHV4WDBsM2pPWnpmN2VxRUt6Um1vVmx5OG5zQ1Q1?=
 =?utf-8?B?aWc4N1U5QUdIbkNTa05UT3IrT0VGcG9JNzZ0c3lTVWQ4d1A5RTZGSWswN0xm?=
 =?utf-8?B?VHhJVEpZN2lDdkRxRy94RW9wL1EvSE1UUGlHK0JDNmZLcTZZMHJhZEwxVnJU?=
 =?utf-8?B?d2xYdktPS2pUTXNlaFVzUlJ4TThyNVRGa2N2SkpwdGp1Z2hSRFRseGZXQ1Fw?=
 =?utf-8?B?SlRxc0dMQ21DcWpTSFFDRGxyTUJNZVRZVmdGbGVEMDJoVWFRcnhLYnJRMDVl?=
 =?utf-8?B?bWtaKzlTNHpEeE83SFNwY2kzK2l4dmN3UWVRZW81a2JTNEoyRkRpLzdwUEE0?=
 =?utf-8?B?UkZPVU5aYnhYSzJhdmxET3o3Y1poTkl2Q01ZNjFOTDRjTjUxd2MvSmtwS0M3?=
 =?utf-8?B?N0NVUkJxcU40L0p1RndLSFpMK2tSZ21QTjJ1V1FwSkVzOGYrSzJIcXoxejJ6?=
 =?utf-8?B?cjFXZlBSLzhNWStSa3JKd0x4V1pqRExpczBnbDNXRWtIMG9DWnd6WDhmQlpl?=
 =?utf-8?B?NFFZN2x3RVBzcHFWOG03dktSempzcDRvZXgxL3Z5MlF5aGFOTmlwek43OFR4?=
 =?utf-8?B?VkR3VHBZanBBMTkrZDZJcjJmVVVlYVE3OW40VnJYSC9aZDAxZWp4bURTRGxM?=
 =?utf-8?B?QjlmQXFlUWFXYU0yTkVrMVh1bEpMTHFwTkFENDZCZUx2SnQ1ZjRXcW9SRkVW?=
 =?utf-8?B?Z0F5aENmaDdMSW5DQ3VJNFpqcVlCSWhRdVlhcWJsMnVGZHJhYVVxZndqNzho?=
 =?utf-8?B?V205dld5aFlPUXpMQmtsV0hZYTB1N3JabWhSd0gyN1ZPbWNCU2JvOHJqRk8z?=
 =?utf-8?B?SXhUZW9SNmk1YzFVczl3YkNhZHV2OE45NXhpa2EyY0IxTlJoTUNjeUlTcW82?=
 =?utf-8?B?MW1ZamRaTVQ0cUFlMVkxVDN1dUQvTzkwM1BpZ1IwckZzSEFwVk9lMmdsdmRu?=
 =?utf-8?B?L0ZGMUxrQy83QU81cHpJNG16K3JOZE9ZSVlpR1dTdXZSZERodFBDM0hSeFl3?=
 =?utf-8?B?V3R6azFEM0xPTWo2UXljdEE4OEorQndmdFZvSi9WMVBHSWgvakhFUFg2Vmlq?=
 =?utf-8?B?eGd0RkVEYzRkTE54NGU5S0hXZ09wU2RpZFRDNTZyNmFpeGVWNzl6N2tvVzhF?=
 =?utf-8?B?OGViVFlnYnEyTGRFWHFIRHNjNHVvUE9WRGxFUyt2cUhlalZ5dWs1RUM3bmx4?=
 =?utf-8?B?NTZ1c1ZjMkFOelNuT2tiM1FFbEdncmxoUUZMNXVrZ2cxT1BNSGdCQXRnWURo?=
 =?utf-8?B?Q0FCUy90WDlia09WT0ZuZFZNT1pLQ1hEWUNIV05jVm9KeTN6UnpDZ205MGRC?=
 =?utf-8?B?U0ZQVlQvb2ZqQ0F1TlJmSHFJd1BLd0dtZFlwMFBwMzBmMlpCNTFKSDZ1d3lP?=
 =?utf-8?Q?3R1hYQnpJBHPIh2HEc=3D?=
x-ms-exchange-transport-forked: True
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OSBPR01MB2983.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0619983c-743b-4235-79cb-08d8ecf77349
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Mar 2021 05:58:00.7298
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f109924e-fb71-4ba0-b2cc-65dcdf6fbe4f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 8nIbC1pEfSrCL9zebYAmV/3weWnI1iRAWxLvmHu5J831GQcEtFvVUjPMDhAaJ5vWnvmMbzt2YXjqtYaUcc0uETFWiIjW9X36ojIZnSi0O0odljupIYZ1LEP4s4/3YGIF
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSAPR01MB2627
MSSCP.TransferMailToMossAgent: 103
X-OriginatorOrg: toshiba.co.jp
Precedence: Bulk
List-Unsubscribe: <https://lists.cip-project.org/g/cip-dev/unsub>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
X-Gm-Message-State: R2zA2GVMAN6KXMga9fi8LWjbx4520388AA=
Content-Type: multipart/mixed; boundary="QHwNkEBI8FaHwG2IWk5e"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1616392690;
 bh=+83ztqyg9mZazk/zhVqdgm1zNw7+E55rqVLA7GzXY/c=;
 h=Content-Type:Date:From:Reply-To:Subject:To;
 b=FGGIfdzdKBIq/gza3/PHKRFSmNuDVPS8FHmjXmYtsk9quyluF034qPO7ChqttJ90L6R
 PcUBlj1oMtX6n6kV6/5cuqO7U5Peu7ebjPlhid7vnmeQxG+lb3ACRosmrDUFi2KpLAzzP
 vphpZagFrN1pQaInzC+zWqIO9cs3NDhoEYE=

--QHwNkEBI8FaHwG2IWk5e
Content-Language: ja-JP
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64

SGkgQ2hyaXMsDQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogY2lwLWRl
dkBsaXN0cy5jaXAtcHJvamVjdC5vcmcgW21haWx0bzpjaXAtZGV2QGxpc3RzLmNpcC1wcm9qZWN0
Lm9yZ10gT24gQmVoYWxmIE9mIENocmlzIFBhdGVyc29uDQo+IFNlbnQ6IEZyaWRheSwgTWFyY2gg
MTksIDIwMjEgNDowNiBQTQ0KPiBUbzogY2lwLWRldkBsaXN0cy5jaXAtcHJvamVjdC5vcmc7IGNp
cC1tZW1iZXJzQGxpc3RzLmNpcC1wcm9qZWN0Lm9yZw0KPiBTdWJqZWN0OiBSZTogW2NpcC1kZXZd
IENJUCBMQVZBIG1haW50ZW5hbmNlDQo+IA0KPiBIZWxsbyBhbGwsDQo+IA0KPiA+IEZyb206IGNp
cC1kZXZAbGlzdHMuY2lwLXByb2plY3Qub3JnIDxjaXAtZGV2QGxpc3RzLmNpcC1wcm9qZWN0Lm9y
Zz4gT24NCj4gPiBCZWhhbGYgT2YgQ2hyaXMgUGF0ZXJzb24gdmlhIGxpc3RzLmNpcC1wcm9qZWN0
Lm9yZw0KPiA+IFNlbnQ6IDE4IE1hcmNoIDIwMjEgMDg6MTUNCj4gPg0KPiA+IEhlbGxvIGFsbCwN
Cj4gPg0KPiA+IFRoZSBDSVAgTEFWQSBpbmZyYXN0cnVjdHVyZSB3aWxsIGJlIGdvaW5nIGRvd24g
Zm9yIG1haW50ZW5hbmNlIHZlcnkgc29vbi4NCj4gPiBVcGdyYWRlIEdvZHMgcGVybWl0dGluZywg
aXQgd2lsbCBhbGwgYmUgYmFjayBvbmxpbmUgbGF0ZXIgdG9kYXkuDQo+IA0KPiBTb3JyeSBmb3Ig
dGhlIGRlbGF5ZWQgbm90aWNlLiBBbGwgb2YgdGhlIGxhYnMgYXJlIGJhY2sgb25saW5lIG5vdy4N
Cg0KVGhhbmtzIGZvciB5b3VyIHdvcmshDQoNCj4gDQo+IEtpbmQgcmVnYXJkcywgQ2hyaXMNCj4g
DQo+ID4NCj4gPiBJJ2xsIGtlZXAgeW91IHVwZGF0ZWQuDQo+ID4NCj4gPiBLaW5kIHJlZ2FyZHMs
IENocmlzDQoNCg0KQmVzdCByZWdhcmRzLA0KICBOb2J1aGlybw0K

--QHwNkEBI8FaHwG2IWk5e
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.
View/Reply Online (#6304): https://lists.cip-project.org/g/cip-dev/message=
/6304
Mute This Topic: https://lists.cip-project.org/mt/81424532/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/4520388=
/727948398/xyzzy [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-


--QHwNkEBI8FaHwG2IWk5e--
