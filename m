Return-Path: <SRS0=5NxB=MX=lists.cip-project.org=bounce+64572+6645+4520388+10495289@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D5A5C4338F
	for <cip-dev@archiver.kernel.org>; Sat, 31 Jul 2021 22:22:32 +0000 (UTC)
Received: from mail02.groups.io (mail02.groups.io [66.175.222.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E522B60EFD
	for <cip-dev@archiver.kernel.org>; Sat, 31 Jul 2021 22:22:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org E522B60EFD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=toshiba.co.jp
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id bueFYY4521723xhaQMOVXuom; Sat, 31 Jul 2021 15:22:31 -0700
X-Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.154])
 by mx.groups.io with SMTP id smtpd.web09.1196.1627770148552703384
 for <cip-dev@lists.cip-project.org>;
 Sat, 31 Jul 2021 15:22:30 -0700
X-Received: by mo-csw.securemx.jp (mx-mo-csw1515) id 16VMMKNE019356; Sun, 1 Aug 2021 07:22:20 +0900
X-Iguazu-Qid: 34trDWJKSnds1GFJQ0
X-Iguazu-QSIG: v=2; s=0; t=1627770140; q=34trDWJKSnds1GFJQ0; m=Rb/A3ykGBVzXb5K8XhUdZOVirP23nmNNTrQrj05EC6g=
X-Received: from imx12-a.toshiba.co.jp (imx12-a.toshiba.co.jp [61.202.160.135])
	by relay.securemx.jp (mx-mr1512) id 16VMMJBj007810
	(version=TLSv1.2 cipher=AES128-GCM-SHA256 bits=128 verify=NOT);
	Sun, 1 Aug 2021 07:22:19 +0900
X-Received: from enc02.toshiba.co.jp (enc02.toshiba.co.jp [61.202.160.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by imx12-a.toshiba.co.jp (Postfix) with ESMTPS id 1565D1000ED;
	Sun,  1 Aug 2021 07:22:19 +0900 (JST)
X-Received: from hop101.toshiba.co.jp ([133.199.85.107])
	by enc02.toshiba.co.jp  with ESMTP id 16VMMIF4023407;
	Sun, 1 Aug 2021 07:22:18 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ITfjYoCAI2L6j3iQpfFTDPpRUIZwR4RuuLVQWqx+LS+pT5w11MaVKn/NLy3jcgO+gWclO2mDJcbboD+I/WMfmvJTQ6XkKYYotQDnEuGlI3QdGpc55Wr3Ge6U2aHmYePSxA2ZMHTfkW1lg61prgrSg39dO3lKmukao8W4ST2gIFkNPzUDZDiF7K2fBLY9jHrHiYO7NetjCwLwNpR5gdnlN0PEiyq/9s8PD/SwFQT2o0PLZAfBnbf1Y4jrvRQsVoIHjjjMon6e+TnMy0eZQf5Hjy7JwapsJ6105PIUnJsZ6hsLmFLrhiH6nJlwhcVY+sBdsA4idhTtDMgzMwesI9tDww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IGzEd46cYRB+CTFtfDLLnzQiKKMQjJfUvfIW5GiZ+XU=;
 b=akw9Xxakg2CovLO3RW3WBj7c1Ipz2A/AaRF/IcmPLkmLiDpoB6S84gC4r97itklXzbpjSbFy2WvPTUAQvR7yo0U54dJK5JSD+WG3lXEXits4FuhG0BjP3XfqQzPwFCdD6tebOGpyfjDarxPc79I1cfCNdcM1wsetd/72bYre90l7L5TI5lQEuYTd6xQ4tZJAU38EAq7QLo4Giz2Gbv0HbIEFCsS2EbKl1CvChaVdrATNTCo5m6FToAdBDEerKXEPIR0cHM+MuX5uCF1OW1qJXQYFkjKQGNV+S8zsFiQ2qZjlGEYQe30kcKcZGpR5ue3KD3tI4pc01f8K6LKk4aWlNg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=toshiba.co.jp; dmarc=pass action=none
 header.from=toshiba.co.jp; dkim=pass header.d=toshiba.co.jp; arc=none
From: "Nobuhiro Iwamatsu" <nobuhiro1.iwamatsu@toshiba.co.jp>
To: <pavel@denx.de>, <cip-dev@lists.cip-project.org>
Subject: Re: [cip-dev] 4.4.277-rt224 released
Thread-Topic: 4.4.277-rt224 released
Thread-Index: AQHXhS1tRXxtd/aP7UyeVeV+3RlpeatdpQPg
Date: Sat, 31 Jul 2021 22:22:09 +0000
X-TSB-HOP: ON
Message-ID: <TYAPR01MB62529CA5354B848A0EDC6BFC92ED9@TYAPR01MB6252.jpnprd01.prod.outlook.com>
References: <20210730102632.GA3234@duo.ucw.cz>
In-Reply-To: <20210730102632.GA3234@duo.ucw.cz>
Accept-Language: ja-JP, en-US
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: c3b0f78a-8c8a-4216-6540-08d95471a317
x-ms-traffictypediagnostic: TY2PR01MB2603:
x-microsoft-antispam-prvs: <TY2PR01MB26036F06636A17250767794492ED9@TY2PR01MB2603.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam-message-info: RvWfAvoG0v3j2OIP4g3nyg9+QJVLcajv2rr3yqUEWrhupPF8NvVhD2x7jdanfNmNN80zhs8AxT1yCbPgmPfAtuyAz+AQSe8y5FyfaCNjPkMAIh9gouf0OryxzYV5EnItTJ9T1E2SrW+Yu9ie8wzmQJopTkyaJvYmjc2lYtbcHyXhFZ67d77ixwAN+C5oDgkJpxmHXxfpl2yIZOzihAttN6eS3D5LF3ObInZc5nYrHRLkINcIDlQ2JznDoSwkbnSxzA/QroYAngyap88kh90zOEEGVpb0vI2qoNjgVx8zWsgdL3ALpzdOi6eBZnYj2WSHfUcuiUmD0WediEuNu0bx++80Cp2cYrpvyuHMGTSHPNxSl5LxJX5DSHzAXoO3s9H9hrV9PBEPfQUHHRvDCS70sUNkW25xnaWtLQz8KgP2Ws3VK5KM+vPjfhqZirphl/G3I+5yuk7Q7Se5ENGEhn3YBrFRPEmTuPY95LbfeNJ+HMXSIURvk4uK/D7JPyhp5ajSIULjbpP29yu2LqZJ/KdZZ5/yqs9U3fNVlWxIBbTTTV1GB8VMII0ic4vg1pUv1j3zf34AE39AqW6H1vgoXZBPmMXc3BIUWz9JLd9GYouV3KyrAR91aUc0JT09zzMzJxaumD7IxnEr2lcyUdj+5jMKMbDLAhMh/0yAH912rOwrjearGY4K7tbNk3lJQbW/WwlVvHXq6QJlv5aBksJ9UqBHu2TVjOKpObmBSNs/aLpyUolt6pb40o5XDpLJGDhF1NqLcyrmFuTmdidxstgRun02Tc47JCV4m7TwuHAp+UODg3A=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?NGI0RG9ycHgvbG1QMUNMYWhSUzFvU1JWNW1vK29LcFI0Ty9YajNEKzljVVZi?=
 =?utf-8?B?SEZYcTB5c0ZhZUZBSVVvNCtORjVPRUl4UHQyZzIySW0yM1VZNmc1VVJGVytI?=
 =?utf-8?B?Z0NPVWVKOG1raTBQNzkvdE4xVkJrTit2VUlBYWlSNUpBYkFjOWwwV28wVGty?=
 =?utf-8?B?Wkw2MGZzRkFYOVRTaDVNNzRCMlFnNXBsMXVQYTBzK0I0aHRjc1R0azNZTVlD?=
 =?utf-8?B?RzNFYjQwb3NSVTByWDRZUTZ0WUt4NE1sYzg2S3ZSMk03UVZONGp2OHJGeFVm?=
 =?utf-8?B?QldkZEVrZDl3Q29XaVRoN3FCTVl1aVdMVGhBVUxuMlRQTmtxU1ZQODg1OE9t?=
 =?utf-8?B?WGpNVzdiSUZsVDRoWWpmOXpsZ3hPWWZ1c2djNHBoV29xemZTaEp3cFJZSlBu?=
 =?utf-8?B?bEl0VmpTa1pieDh2dXU1ZEMrNER1OWFOUGFhRU1teUp5Vk81eHJsbVNIZW83?=
 =?utf-8?B?bzg4YnZVRDZqSjRIWm92dE0vbXhYamZmUmdNV2s5TmdITmcwRU9vYzlRK2Vj?=
 =?utf-8?B?RjJVMGJpeGpldDNXUWJaNkFIeU9OS2FVd1ZjVnEyWFFNTzdHTFlSVmlYQXAr?=
 =?utf-8?B?S0UvdldhVGkvdWJmTWJCZmtLRWQwdkdBTXRaeXVlUjNUc09oYmcxQWp3QW9Z?=
 =?utf-8?B?dXNSWFdwK2hNR004SDEyWStxcVkzdytCYmo0Z1FyWHhLYXU1NG1tblgrRDBz?=
 =?utf-8?B?cU5Gei92WlZkUUdia2dUWjlMdnVtRDF0aFBBM0VDc09leFNUT1pYVzc4ZmNT?=
 =?utf-8?B?OWY0U0FpcWw4eVY4cVlTRWU0WmJ1NHo1Nk1QamNpKzZXWktEb2UrV3ZuZFZL?=
 =?utf-8?B?dk9jZFNqNlhMZ05EZ0J6L0lCV1Q3a05ZOUtVVEpXKzFnVHdXMEdzYUNxMlIv?=
 =?utf-8?B?VFRNOXNLcEoyOS9OK0lLRU9ibmg0SlZNam5yajZnWkVGSFF6eGNiY0VVNzRI?=
 =?utf-8?B?OHppcHdYODBpTFlmOVovSUEvaFQ5ZWprcGdkQkRrQkVjSVA0aDZCcXFmTmVW?=
 =?utf-8?B?b2lqejRscnluOXYrNm9pNm5yQUwrK0tYM1B2WVR3YmtHNDBhd2MxbFhodmI2?=
 =?utf-8?B?bjZDUVZEVklTbXJXQURxUXVHVXRNZ0dHcHZzU01mdE9GbzVvMFRteGQ0VVdZ?=
 =?utf-8?B?V2xlK2F6bFNaQjh6UlBNQmZiVnhmVlpLbnJmeWY4TE9nUDNscG5LdEgwalJp?=
 =?utf-8?B?VXUyTnJEWVN4YWpmYjBPRnZqZTAxTVBlN09PQnVWKzgxSWM1RExyY1loY0Nn?=
 =?utf-8?B?djZLUUQ4aWFHRzNNS3M0SGt6Rkx0WHQ2US9zZmE1aDhMZjQxRHM4eWJ6dTVr?=
 =?utf-8?B?bFl6dXJBUk9WYTNleVpKMW83RklqaGQ5eFJSa3k5K1FuV1U3bFlTaGhDYUps?=
 =?utf-8?B?OWZIS1hQQlZyVkhUUFd4QWZuWEhEV2pvcWVJWVp3QlNYQ2c1VU9QbytUM1ZL?=
 =?utf-8?B?RUYvWmoxdENGNFo3WWx4cWxTU1VoYkowU1BvRXpxbXlIY2NveEpIMXZTNnhz?=
 =?utf-8?B?VzRsQUEzWUFxVlVySCtFS2dYODg0QyswUzZscHhXSmV1MzVsbXVKYjJ1VmFW?=
 =?utf-8?B?dDFTbFh5Ynptc1FYd3A3Sm1WeW44Rk1DNm9DWmp2N3VxWSsyeFM5UFhObC8z?=
 =?utf-8?B?OFEvU3cyNzYwV3FNTWFSRzBoYXhsQTVaMjcxMTd3Q3h4ZkgvaTlIL1ZIVHQy?=
 =?utf-8?B?RFl6WG5UK211SkpCYkQzdzRTNmpoMjVSS0ZJazhCMG9qOFFaQiszWTMzWGtG?=
 =?utf-8?Q?I6XjOM70FK553Ezxbk=3D?=
x-ms-exchange-transport-forked: True
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYAPR01MB6252.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c3b0f78a-8c8a-4216-6540-08d95471a317
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 Jul 2021 22:22:09.2857
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f109924e-fb71-4ba0-b2cc-65dcdf6fbe4f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 25DxAcHsxtTCnJJcIlBUhSYIJAQkRpdxVH/8WdbVSdrQDCldmvASUR4/4Q0ihqUrfl5UfY2XMOMHt101DWK0mrH6tROCRqzT9oP9as+FstxTVA4kskWp6PCO540AIeoU
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY2PR01MB2603
X-OriginatorOrg: toshiba.co.jp
MSSCP.TransferMailToMossAgent: 103
Precedence: Bulk
List-Unsubscribe: <mailto:cip-dev+unsubscribe@lists.cip-project.org>
List-Subscribe: <mailto:cip-dev+subscribe@lists.cip-project.org>
List-Help: <mailto:cip-dev+help@lists.cip-project.org>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
X-Gm-Message-State: CLYk5PiCxM2xGBdMx9Cpj3zdx4520388AA=
Content-Type: multipart/mixed; boundary="a7eiFraTeTcp5T7NRmLT"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1627770151;
 bh=YtFKavRkj8cKEFyuj1J5iKlEE5Yo+AbRc3w7yp80bXE=;
 h=Content-Type:Date:From:Reply-To:Subject:To;
 b=W28ufDDyJmWwtZj0/wU7BxW39WtsEKpgzhPYgn51rbjahLCIAkkkjBHJoJCMk8C/U6C
 oZvNbeMwA/FmGxd8a2i2DkpI76Pq5JD2YGMC+iyEc1JHUOsgdRwmBlVt34hMe7Z5EpOFr
 m6uapyrxG41OJKO60mSHcv9RRth3ESsY/H0=

--a7eiFraTeTcp5T7NRmLT
Content-Language: ja-JP
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64

SGkgUGF2ZWwsDQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogUGF2ZWwg
TWFjaGVrIFttYWlsdG86cGF2ZWxAZGVueC5kZV0NCj4gU2VudDogRnJpZGF5LCBKdWx5IDMwLCAy
MDIxIDc6MjcgUE0NCj4gVG86IGNpcC1kZXZAbGlzdHMuY2lwLXByb2plY3Qub3JnOyBpd2FtYXRz
dSBub2J1aGlybyjlsqnmnb4g5L+h5rSLIOKWoe+8s++8t++8o+KXr++8oe+8o++8tCkgPG5vYnVo
aXJvMS5pd2FtYXRzdUB0b3NoaWJhLmNvLmpwPg0KPiBTdWJqZWN0OiA0LjQuMjc3LXJ0MjI0IHJl
bGVhc2VkDQo+IA0KPiBIaSENCj4gDQo+IDQuNC4yNzctcnQyMjQgaXMgb3V0LCBhbmQgaXQgd291
bGQgYmUgdXNlZnVsIHRvIGRvIC1jaXAtcnQgcmVsZWFzZQ0KPiBiYXNlZCBvbiB0aGF0LiBXb3Vs
ZCBpdCBiZSBwb3NzaWJsZSB0byBkbyAtY2lwIHJlbGVhc2UgYmFzZWQgb24NCj4gNC40LjI3Nz8N
Cg0KWWVzLCA0LjQueSB3aWxsIGJlIHJlbGVhc2VkIG9uIHRoZSBzZWNvbmQgRnJpZGF5LCBidXQg
d2UgY2FuIHJlc2NoZWR1bGUgaXQgZm9yIHRoZSBjaXAtcnQgdHJlZS4NCjQuNC4yNzcgaGFzIGJl
ZW4gdGVzdGVkIGJ5IGF1dG8tbWVyZ2UgYW5kIGF1dG8tdGVzdCBhbmQgY2FuIGJlIHJlbGVhc2Vk
Lg0KDQpodHRwczovL2dpdGxhYi5jb20vY2lwLXByb2plY3QvY2lwLWtlcm5lbC9saW51eC1jaXAv
LS9waXBlbGluZXMvMzQ0MDQ5OTExDQoNClNvLCBJIHdpbGwgcHJlcGFyZSBmb3IgdGhlIHJlbGVh
c2UuDQoNCkJlc3QgcmVnYXJkcywNCiAgTm9idWhpcm8NCg==


--a7eiFraTeTcp5T7NRmLT
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.
View/Reply Online (#6645): https://lists.cip-project.org/g/cip-dev/message=
/6645
Mute This Topic: https://lists.cip-project.org/mt/84547413/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/10495289/452038=
8/727948398/xyzzy [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-


--a7eiFraTeTcp5T7NRmLT--
