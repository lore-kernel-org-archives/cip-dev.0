Return-Path: <chris.paterson2@renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7EFFBC4332F
	for <webhook@archiver.kernel.org>; Tue, 12 Dec 2023 10:07:55 +0000 (UTC)
Received: from JPN01-OS0-obe.outbound.protection.outlook.com (JPN01-OS0-obe.outbound.protection.outlook.com [40.107.113.121])
 by mx.groups.io with SMTP id smtpd.web10.13372.1702375667634110017
 for <cip-dev@lists.cip-project.org>;
 Tue, 12 Dec 2023 02:07:48 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@renesas.com header.s=selector1 header.b=RRVTEmxq;
 spf=pass (domain: renesas.com, ip: 40.107.113.121, mailfrom: chris.paterson2@renesas.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jgb6zCgnMLUPMiaD3tXqJsAfV50LiQUCJJgmz+tSkLxDj2jXnyTrlblKtZjNn4xTrSNcEkUdajxTf9SjLP51CvGaA+tQ0Vm0KEiMunWONHpZUjBLFjV7o6eaG7LpAu8oiOrLvBAZASLn+VguknFmU0ClfRumkCBMtiRKgHSnL0m594EZeKgsaCXx3+G7OuqJv5r7HvxGqf/zyCczz3OPArIa+0hoy5LA4IFZb+e5rlMPOt/tRuRK55p2X/R5+qa6wrXYvDFUteZILwY8tpiTEzHMDu1/KSrs165y87EQprkDOZ574ClFoV41xs475YPF2aj4+RiHm7u6kqdtKDuM4Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4XKvGpZhNTkldBFwPxQGuptFOd5bI+lR+m7abH2GJaU=;
 b=CT3b4GnnlTxBfYRZ261LgZasDg7CwTX8JIIvMR5GXBdNxETg2ym91RTKmfY3xjvHwOunjVsG96K1x/GK6LLe+6GvKVncN570t2uJmtoYOBgYV//DUfDjvrvteVpidjCKTko8plUvdCeNue3GHQz4nzy2pvKrQpHxNa09FYsd1z5zbyfikFqK/13OU/nZTcxGNh2S1d81xU9IEZsgbGWXEJOHhDbZcwuczIg0y7ZXAGloBDbsvOZrqHAUROkejYGqxhvwH7zA2UnSK89c4keFjWRDbbgR1GmzbT3zNMZev+GY47e9eaFMW4QwjQEUxXJLO1xod6NMbEkk8ekiwVwEkw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=renesas.com; dmarc=pass action=none header.from=renesas.com;
 dkim=pass header.d=renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4XKvGpZhNTkldBFwPxQGuptFOd5bI+lR+m7abH2GJaU=;
 b=RRVTEmxqz498cqpmEbXGy9GdqlJwxk3X5bB6+9/4PIYQ+5hbjnog2zHaGyq79MKA+HCvqnP+SvP49T3eYogLbTJKcsW9Vyp0KIV1voZVbR+v6ZyKOqhfKL3ANHxG+t5XyadWuJK+RVRgOe6cDh6HzofHzQaZhTF0YLomcT9ErVM=
Received: from TY2PR01MB3788.jpnprd01.prod.outlook.com (2603:1096:404:dd::14)
 by TYWPR01MB8623.jpnprd01.prod.outlook.com (2603:1096:400:13c::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7091.25; Tue, 12 Dec
 2023 10:07:43 +0000
Received: from TY2PR01MB3788.jpnprd01.prod.outlook.com
 ([fe80::6779:9c53:db73:8052]) by TY2PR01MB3788.jpnprd01.prod.outlook.com
 ([fe80::6779:9c53:db73:8052%4]) with mapi id 15.20.7091.022; Tue, 12 Dec 2023
 10:07:43 +0000
From: Chris Paterson <Chris.Paterson2@renesas.com>
To: "cip-dev@lists.cip-project.org" <cip-dev@lists.cip-project.org>
Subject: FW: KernelCI is designing a new Web Dashboard: we want your feedback!
Thread-Topic: KernelCI is designing a new Web Dashboard: we want your
 feedback!
Thread-Index: AQHaLGdQspISUWD2XkOTjChxZjB1GLClbNTg
Date: Tue, 12 Dec 2023 10:07:43 +0000
Message-ID: 
 <TY2PR01MB3788AA3EE1F835904091B9CAB78EA@TY2PR01MB3788.jpnprd01.prod.outlook.com>
References: <5d48c1fa-d577-6f4c-5d3c-37884053e1a9@collabora.com>
 <CAHrXaCvAf=bB-mHix4ai_J3vkzMmzm37QzdPgPzKx8gs2GLtQg@mail.gmail.com>
In-Reply-To: 
 <CAHrXaCvAf=bB-mHix4ai_J3vkzMmzm37QzdPgPzKx8gs2GLtQg@mail.gmail.com>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TY2PR01MB3788:EE_|TYWPR01MB8623:EE_
x-ms-office365-filtering-correlation-id: bd997dd0-46e7-456e-f6a7-08dbfafa2eaf
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 fcjZTXNGuJ0omhBzBwJOCq1+X6xgIL6snv/axvDueL8qCewtUWEOO+kBiLSBjcleMEpv5TI47ypi6cdjhI+zE8kPSRhQYCeNeQXQZwuFtySyE835dd5u3UONA3QDhLMyVJr7bu24bfaQU+0vpHZLKSP+LPOkcy/flYl9aJBQwNsVJi/vcdot7P97cF0F+bOqQVtBcdkUxK3ojm+PQcsL7Uy9qr5r2Ho7FfBXg5jIBlC4ksUnGBmmYzKkQy8AIOB9J227p4wzvzvw81OHcP+1EwQN8/Zjz2nS8asGjetGwY202/wusUo1w0uQFqXaqkni0XXD/Mw1msGGRn7RsRyCjj+HlyQgpWGd0lYtLt/6XH4TThMf+tK7XonCStbwnsjlCQ0yIUAfS9Wvcrko0R/cb5qakliNSlOx1d6iLhYprbW4Yxbbcmh3VTaMD2PQuGUlxEys8fW4Vam7/RIoQbF0UWnJsQAqJKANxlnBmJG3hLGGsOlPgdij9OBN/9NbVnjKtntbq16eYIvWO4WpiJHR+AyzZk+TF44ErgxMzUMwzaNUSBOyBoQMNbP7YyjTLjQGmiJAtQpujlKgpC5EWxfvkqzTmAFIW8IYDhYoh25w7D4=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY2PR01MB3788.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(346002)(39860400002)(396003)(136003)(366004)(230922051799003)(451199024)(186009)(64100799003)(1800799012)(66574015)(26005)(83380400001)(9686003)(55236004)(6506007)(7696005)(53546011)(38100700002)(5660300002)(8676002)(8936002)(52536014)(41300700001)(2906002)(966005)(6916009)(71200400001)(478600001)(316002)(64756008)(66476007)(66946007)(66446008)(66556008)(76116006)(33656002)(86362001)(122000001)(38070700009)(55016003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?utf-8?B?MTFQOE5STVdwbVVid1ZyVy9rNWd4WFlsY0dVdGlsN25nRkp0c0pIQk5WZlIv?=
 =?utf-8?B?WlU1VzVLZDJDQVFtYTR1UjEzSkk2L3Q0dG54cTRERE1mdWhEaHZIcTZmTU1L?=
 =?utf-8?B?S0dDLzdUTWFtMWpEcW5USEh2R0JENlRDTUQveFdIREZOUlNwdTZVbEZQT1ZD?=
 =?utf-8?B?VjM1THdtSGVSUGw4bmlSTXlnclJNYnVuMi9ZczRPTVhXbjVpYkdNeHd4RitK?=
 =?utf-8?B?ejVJVE1tRmx6cEpYTzUrTk45TDZEckc5cHMzWlRlT1pzUEhOdVFQYzBvU0FI?=
 =?utf-8?B?R1EyWS8rTkoxMXBjU2w2bmlIVk81UkE0ZXJUZHgzZ04rOTZGRllMdzBsVVNY?=
 =?utf-8?B?NTJLUUdoQ0pVSzhGT0d4SmE2ZzBJc1NnRVpjMHZ1dUlvelkyQW5YRjdXcGZ1?=
 =?utf-8?B?NkpENG0vOGtpK2ZsZCtGVGVmc2kvd2JVbHBsZWJCUis4VkQvN2J5Y0RQTlFz?=
 =?utf-8?B?emtzbHFoK2hQTittb3JqM0p5bWR1dFZjMTFPSis1S0M5UjlEZDJid2dZN2Mw?=
 =?utf-8?B?OFArNTJvQzVxZlkzYjZwc0V1MWdaSXRtc1UyZ1duM0Q2dDJTZ2NpMmVoNlFB?=
 =?utf-8?B?cmJjZ0MyN0ZhVDlxbEwwUzc1d0F1ZjhSRXByb3ZkOXBYYXRBZmtwbWZUVXdC?=
 =?utf-8?B?WVA2L0crZVV2YllwOURHOXVnOHZCNlU0YmFBWDc4WXJacWlHRFIrV2t3VUho?=
 =?utf-8?B?a25rdkppQU0rQ0hFZjU2bTltM0JKWHh5MmFITi9TVzRWbGVTU2pkSVRqS1gv?=
 =?utf-8?B?K3VUak5wcy9GbzdrWm8yOEtVV2w2YWFka3VOVzZXcXpzc3JSdTV5VHhTSlRx?=
 =?utf-8?B?WUZ0bVQ4bzRlYUhlKzRMR21UZ3d5ZU11cEw0aXJhd3o0eUd0UU1WZ3JyZkN4?=
 =?utf-8?B?Rmk2QUJTWXNqcGx3M3dGN3RrZmN4WlIreFh1dGdYdGdiS014endMTXJUNnVk?=
 =?utf-8?B?eFBQdE9pRTA2WEdjYWk1WUZPVE1jbnpiTEpCWEN4R0c4ak10b2RydTRSSFVM?=
 =?utf-8?B?NEYxZXBUa01vQ1QwWUNuVllCc3lPVUVFUjN5a0lSMElITzVad2Q1NzVDQVVQ?=
 =?utf-8?B?eHRmMjZkN1JTSkp3ZEJtRVlzbnNPWDZqWjh3ZStqcHhSZFBRSXNudDRVdWNY?=
 =?utf-8?B?ejBGd2Jkejl6aTE1SWordFFhazRBSjU0b3RFU1Y3b2tGVFp0emFPSkxITU5n?=
 =?utf-8?B?c2xTdkQ1TWNqSDZEenBYMnptTkg4NEs1MWE0NmRENjJHdldBUnlpUjNjbFA4?=
 =?utf-8?B?R0pkMlhsRFBVUTMyTjFYQnVMa2R2RlcxS1hzU1hWNWRYY3VMSFl3TkJNS082?=
 =?utf-8?B?RTV2bnZhY09oN3NKZytyZCtSZ1NoWnJzRG9sWXQ0a0tUOTlXdUdLUVZyK04w?=
 =?utf-8?B?VnBKSmFnZ0lRdmIvZk9hYjU0b1p6SnYxcjFJbGd4V1pORFNJMTIyT1VKYytV?=
 =?utf-8?B?MnhHVFZLSC9uZ1lHWllGclJIdURydGRJUkVMc0xrY2FWVW9LbCtVclR5a3A1?=
 =?utf-8?B?ZGlrKzlpWEh4QmZENzd0QmtTRlV5OFB3bEZxUDRrcUdTb2lQWjZsRjZPdXpa?=
 =?utf-8?B?WVJkQUIyUXhTYVJ0TjlEbjJBQU9SemlMZm5uMmp5QlVLNVQ5TzMxMVlIV1Yy?=
 =?utf-8?B?QXhxQ3l5MUpUVncvN0w1YjRoQ0JNZnFpYStuMmlhRUxTWjdZMkdLaUdPdmFB?=
 =?utf-8?B?T3RHVGVmNTNRYmlZU3BISTR6NDY2NWQrV1M4eFgxK2VrSjJoYXhNQ2YrWGlK?=
 =?utf-8?B?ais2SGRZaW9QWHVDNkRmTnFOSzBUQllHL3hTMmtTa2J5ZTlTUUdXaS94TVUx?=
 =?utf-8?B?V0V3VDVuV0FMSk9vaWFjQ2l0WWlXK3RJY05jY29YbnkybjM0d1Z5cTdubUhP?=
 =?utf-8?B?M0JUVVNpaFRHeWRiRFZMOG41NjVUaVl5OUVPZ0FQRGFLV081VlpCb2ZxK1ls?=
 =?utf-8?B?S2t6SWh5bi9xNnZCLzNVSjNrd0xRZXd1S2RvalR0THlqVzh1bjlnZzV4Q3NZ?=
 =?utf-8?B?c2xZK0E4K29TWTRwVXBnNWU5dFkxQ3M0MzdWTHNFN29wbkZEMW1HbCtkMlNr?=
 =?utf-8?B?ZnlCSTkxT3FxMkozRituWXgzZHJ3ZzBsdFR5NkFWbDZ5Y0FHUTc5bTl6Ym53?=
 =?utf-8?B?ajJrRFBFNGN2bTF0WTErYnlUOVZMNGJhLzhNSnBOekxpNzEvb3R2dENFL3RF?=
 =?utf-8?B?S3c9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY2PR01MB3788.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bd997dd0-46e7-456e-f6a7-08dbfafa2eaf
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Dec 2023 10:07:43.5066
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: mvbj+1UsT6PYOBeafsx5uNLDi0N7XiY0P1bnuIEG7qCHxSWj2LdjGriGaMpk7WvIMI2OHEien+HNpRyQSmAcVsDgnnrpEelGA2zihjFUIi8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYWPR01MB8623
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 12 Dec 2023 10:07:55 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/14042

SGVsbG8gYWxsLA0KDQpJZiB5b3UgaGF2ZSBhbiBpbnRlcmVzdCBpbiBLZXJuZWwgdGVzdGluZyB0
aGUgS2VybmVsQ0kgd291bGQgYXBwcmVjaWF0ZSBpdCBpZiB5b3UgY291bGQgY29tcGxldGUgdGhl
IGJlbG93IHN1cnZleS4NCmh0dHBzOi8vd3d3LnN1cnZleW1vbmtleS5jb20vci9QSEcyQkM1DQoN
ClRoYW5rcyENCkNocmlzDQoNCi0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQpGcm9tOiBSaWNh
cmRvIERvdXJhZG8gPHJpY2FyZG8uZG91cmFkb0Bwcm9mdXNpb24ubW9iaT4gDQpTZW50OiBNb25k
YXksIERlY2VtYmVyIDExLCAyMDIzIDc6MjIgUE0NClRvOiBHdXN0YXZvIFBhZG92YW4gPGd1c3Rh
dm8ucGFkb3ZhbkBjb2xsYWJvcmEuY29tPg0KQ2M6IGxpbnV4LWtlcm5lbEB2Z2VyLmtlcm5lbC5v
cmc7IGtlcm5lbGNpQGxpc3RzLmxpbnV4LmRldjsgYXV0b21hdGVkLXRlc3RpbmdAbGlzdHMueW9j
dG9wcm9qZWN0Lm9yZzsga2VybmVsY2ktd2ViZGFzaGJvYXJkQGdyb3Vwcy5pbzsgSm/Do28gQmVy
dGFjY2hpIDxqb2FvYmVydGFjY2hpQHByb2Z1c2lvbi5tb2JpPg0KU3ViamVjdDogUmU6IEtlcm5l
bENJIGlzIGRlc2lnbmluZyBhIG5ldyBXZWIgRGFzaGJvYXJkOiB3ZSB3YW50IHlvdXIgZmVlZGJh
Y2shDQoNCkhpIGNvbW11bml0eSBtZW1iZXJzLA0KDQpXZSB2YWx1ZSB5b3VyIGlucHV0ISBQbGVh
c2UgdGFrZSBhIG1vbWVudCB0byBzaGFyZSB5b3VyIHRob3VnaHRzIG9uDQp0aGUgS2VybmVsQ0kg
V2ViIERhc2hib2FyZCB0aHJvdWdoIG91ciBxdWljayBzdXJ2ZXk6DQpodHRwczovL3d3dy5zdXJ2
ZXltb25rZXkuY29tL3IvUEhHMkJDNQ0KDQpUaGlzIGlzIGdvaW5nIHRvIHRha2Ugb25seSA1IG1p
bnV0ZXMuDQoNCllvdXIgZmVlZGJhY2sgaXMgY3J1Y2lhbCBpbiBlbmhhbmNpbmcgdGhlIEtlcm5l
bENJIFdlYiBkYXNoYm9hcmQncw0KdXNlciBleHBlcmllbmNlLCBzYXZpbmcgdGltZSwgYW5kIGlu
Y3JlYXNpbmcgcHJvZHVjdGl2aXR5LiBXZQ0KYXBwcmVjaWF0ZSB5b3VyIHRpbWUgYW5kIGNvbnRy
aWJ1dGlvbi4NCg0KQmVzdCwNCg0KDQpPbiBUdWUsIERlYyA1LCAyMDIzIGF0IDg6MzjigK9QTSBH
dXN0YXZvIFBhZG92YW4NCjxndXN0YXZvLnBhZG92YW5AY29sbGFib3JhLmNvbT4gd3JvdGU6DQo+
DQo+IEhlbGxvLA0KPg0KPiBUTDtEUjogS2VybmVsQ0kgZW5nYWdlZCB3aXRoIGFuIFVYIHNwZWFj
aWFsaXN0IHZlbmRvciB0byBkZXNpZ24gYSBuZXcNCj4gd2ViIGRhc2hib2FyZCB0byBzaG93IG91
ciB0ZXN0IHJlc3VsdHMgZGF0YS4gSWYgeW91IHdhbnQgdG8gZ2l2ZSB5b3VyDQo+IGZlZWRiYWNr
LCBsZXQgdXMga25vdy4gV2Ugc3RpbGwgaGF2ZSBhIGZldyBzcG90cyBmb3IgVVggaW50ZXJ2aWV3
cyENCj4NCj4NCj4gQXMgd2Ugc2hhcmVkIHByZXZpb3VzbHksIHdlIGFyZSBpbiB0aGUgcHJvY2Vz
cyBvZiBkZXNpZ25pbmcgYSBuZXcgV2ViDQo+IERhc2hib2FyZCBmb3IgS2VybmVsQ0kuIEFzIHlv
dSBtYXkga25vdywgYXQgc2FtZSB0aW1lLCB3ZSBhcmUgcHV0dGluZw0KPiB0b2dldGhlciBhIG5l
dyBjb3JlIGluZnJhIHRvIHJlcGxhY2Ugb3VyIGxlZ2FjeSBhbmQgbGltaXRlZCBzeXN0ZW0uDQo+
DQo+IFVsdGltYXRlbHksIHdlIHdpbGwgaGF2ZSBhIENJIHBpcGVsaW5lIHRoYXQgYWxsb3dzIHRl
c3RzIHRvIGJlIHJ1biBub3QNCj4gb25seSBpbiBLZXJuZWxDSSBsYWJzIGJ1dCBvdXRzaWRlIG9m
IGl0IHRvbywgYnV0IHdpdGggdGVzdCByZXN1bHRzDQo+IGNvbnRyaWJ1dGVkIGJhY2sgdG8gdGhl
IGFscmVhZHkgYXZhaWxhYmxlIGNvbW1vbiBkYXRhYmFzZS4gVGhlbiBvbiB0b3ANCj4gdGhhdCwg
d2Ugd2FudCB0byBoYXZlIGEgcG93ZXJmdWwgZGFzaGJvYXJkIHRvIGhlbHAgdGhlIGNvbW11bml0
eQ0KPiBldmFsdWF0ZSB0aGUgdGVzdCByZXN1bHRzIGluIHRoZSBiZXN0IG1hbm5lciBwb3NzaWJs
ZS4NCj4NCj4gWW91IGNhbiByZWFkIG91ciBibG9nIHBvc3QgZm9yIGEgcXVpY2sgc3VtbWFyeSBv
ZiB0aGUgVVggcmVkZXNpZ24NCj4gcHJvamVjdDogaHR0cHM6Ly9rZXJuZWxjaS5vcmcvYmxvZy9w
b3N0cy8yMDIzL3V4LWFuYWx5c2lzLw0KPg0KPiBXZSBoYXZlIGp1c3Qgc3RhcnRlZCB0aGUgZmly
c3QgcGhhc2Ugd2l0aCB0aGUgVVggdGVhbSBpbnRlcnZpZXdpbmcNCj4ga2VybmVsIG1haW50YWlu
ZXJzIGFuZCBvdGhlciB1c2VycyBvZiBLZXJuZWxDSS4NCj4NCj4gSWYgeW91IGFyZSBpbnRlcmVz
dGVkIGluIHByb3ZpZGluZyB5b3VyIGZlZWRiYWNrIGp1c3QgcmVwbHkgdG8gdGhpcw0KPiBlbWFp
bCBvciByZWFjaCBvdXQgdG8gbWUgZGlyZWN0bHkuIFdlIHdpbGwgdHJ5IHRvIGFjY29tbW9kYXRl
IGV2ZXJ5b25lDQo+IHRoYXQgaXMgaW50ZXJlc3RlZC4NCj4NCj4gUmVnYXJkcywNCj4NCj4gLSBH
dXMgKGFzIFByb2plY3QgTWFuYWdlciBmb3IgdGhlIEtlcm5lbENJIHByb2plY3QpDQo+DQo+IC0t
DQo+IEd1c3Rhdm8gUGFkb3Zhbg0KPiBLZXJuZWwgTGVhZA0KPg0KPiBDb2xsYWJvcmEgTHRkLg0K
PiBQbGF0aW51bSBCdWlsZGluZywgU3QgSm9obidzIElubm92YXRpb24gUGFyaw0KPiBDYW1icmlk
Z2UgQ0I0IDBEUywgVUsNCj4gUmVnaXN0ZXJlZCBpbiBFbmdsYW5kICYgV2FsZXMsIG5vLiA1NTEz
NzE4DQo+DQoNCi0tIA0KUmljYXJkbyBHZWrDo28NCg0KU2VuaW9yIFVzZXIgRXhwZXJpZW5jZSBE
ZXNpZ25lciBmb3IgS2VybmVsQ0kgV2ViIERhc2hib2FyZA0KDQo=

