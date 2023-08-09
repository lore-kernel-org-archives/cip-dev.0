Return-Path: <nobuhiro1.iwamatsu@toshiba.co.jp>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0CBE3C0015E
	for <webhook@archiver.kernel.org>; Wed,  9 Aug 2023 06:33:55 +0000 (UTC)
Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.131])
 by mx.groups.io with SMTP id smtpd.web11.82686.1691562832455079648
 for <cip-dev@lists.cip-project.org>;
 Tue, 08 Aug 2023 23:33:53 -0700
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: toshiba.co.jp, ip: 210.130.202.131, mailfrom: nobuhiro1.iwamatsu@toshiba.co.jp)
Received: by mo-csw.securemx.jp (mx-mo-csw1120) id 3796Xf5E3200682; Wed, 9 Aug 2023 15:33:41 +0900
X-Iguazu-Qid: 2rWhoCDaO5aE7L1jQP
X-Iguazu-QSIG: v=2; s=0; t=1691562821; q=2rWhoCDaO5aE7L1jQP; m=BRUhMjBiHS97K7KG2+E5JdhbDoQ48MKKILOCvdksLoU=
Received: from imx2-a.toshiba.co.jp (imx2-a.toshiba.co.jp [106.186.93.35])
	by relay.securemx.jp (mx-mr1121) id 3796XdHW1264051
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
	Wed, 9 Aug 2023 15:33:39 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=im/5WXg1/dgSnN2YHUu6maGvfhpPJj8K8Iianw0mAjSn75nf6fYClo1OlPouVQ8TVldK9eiQXlxEfrklzOXmvIQRn1GcNgMFW6GmqXmmrihSmXfTGmRaG8adGsyw/gxWBHiQzxfteusF0BdQyextoO5o8GuNdF/+xdmugN8mLzVlg7iDwVPxi36w6KM2Ck78v3icvDuc+xamYIGCAzTWYxzRbic0IiJHaVXyGjo3BIrjAMdV2+cM4KX8PIAtZMwCVNoQQqXF2Mj0OxfL+auxMbhykM12F1KKgz476GgqwJX961CSAow9rRCjPRvvRUGUbOWn/UxQX3otRnupQcrcjQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3yODE/DUorrW4qKUHhwfLbN6GbJ+dnxFr+osY5rnfmI=;
 b=fBwjx/Y3kwVt2i+SuAVA/Qhx5C6xw4SUBDgYCa0vL5WVwhV88g1ThbO/+19jT4QKBb+YJnjGpiZ8HZwjZiHa+DgFEkK1yNmmra38zVP2zVCGtBf6u+dCfQe2u27eXNtm2wNXuZpU+TR9hSg+hapGrB1f5kh8t403HvnDNn69HVOiGi+G72y1dokDIFH4vxrhDHE/o/xbXaiFTY+pLhfJ4lEy1PB1NBhTUO8fAh/1gwi0HH/CbCHmTENwuS9EAQzMHfI09tK12Lb6Gd4P3aHDSI8pyoggF0w/6xH4PCzM6fEOFucU65+3I0zB47K76Rr7FjauAFaihoHQPlUHNIohAQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=toshiba.co.jp; dmarc=pass action=none
 header.from=toshiba.co.jp; dkim=pass header.d=toshiba.co.jp; arc=none
From: <nobuhiro1.iwamatsu@toshiba.co.jp>
To: <biju.das.jz@bp.renesas.com>, <cip-dev@lists.cip-project.org>
CC: <pavel@denx.de>, <fabrizio.castro.jz@renesas.com>
Subject: RE: [cip-dev] [PATCH 5.10.y-cip v2 00/13] Add RZ/{G2L,G2LC,V2L} MTU3
 support.
Thread-Topic: [cip-dev] [PATCH 5.10.y-cip v2 00/13] Add RZ/{G2L,G2LC,V2L} MTU3
 support.
Thread-Index: AQHZuvGD9Mo8H4j9JkOQdisgF97/xq/C8D+AgB5jY6CAAEvcAIAAAUlg
Date: Wed, 9 Aug 2023 06:33:37 +0000
X-TSB-HOP2: ON
Message-ID: 
 <TYWPR01MB9420C087763F6F05782CCBB79212A@TYWPR01MB9420.jpnprd01.prod.outlook.com>
References: <20230720100350.247386-1-biju.das.jz@bp.renesas.com>
 <ZLl0jyHulqBdQ99x@duo.ucw.cz>
 <TYWPR01MB9420DA0FDACEADDE4A7BD6F19212A@TYWPR01MB9420.jpnprd01.prod.outlook.com>
 <OS0PR01MB592269E73058D45F9362C0938612A@OS0PR01MB5922.jpnprd01.prod.outlook.com>
In-Reply-To: 
 <OS0PR01MB592269E73058D45F9362C0938612A@OS0PR01MB5922.jpnprd01.prod.outlook.com>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=toshiba.co.jp;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYWPR01MB9420:EE_|TYWPR01MB9694:EE_
x-ms-office365-filtering-correlation-id: 4b264632-b35f-43a7-8b4d-08db98a2905a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 QPVdx4a2GGFUyO1zR7D4OvlWOfIVAcpA+gbk7ZpAyvzCPmJgQbC6F5C4HNjkeavs5XJCvFfy88clMd0J5fX3EHIEqcqMhBlf2l2+Fet2KiPrgcoDtF00PdlaP0Cxzx6XGhkwF7Smp/gyVehVKj5BaJCVVgYD6cEH+9ed++r0IxD+SGoYhULVMV36cUh/3cVoRlSYCowuBIjKR5TrITHs/L0LtO0BrQ1M2BqfA+C8n4NK10rJK9jlYEDEMSTUVmeuQ9evVhiZl6QCgRn1pdcU2RBc+CFXaGTf2uah+L9DHo11BcB9OUcTnXgHGm3wPJt4eaK1AXcJIgAIpr3RD5g92EEnATkzP08I6d06FsQdRjZEB0iXy70G2W5avUi94fJvGoT8X9589bx9zh9oNkNlBHEG+Ltku/YULiUA/mxHQrwdIDSjYZmC10DqrVhG5yYFj5E/npa+HZRNWxdX3Gc87kUm8McPmnpvxA/AJMYwwPgrnA5rdRbqR0QPbOzu3JCmRFuq9SKDafH/faUKyl5Nn4V7gGC2j50xSBZpngzhwqA00ZHImDfVTeRFA5az1FuoDSpv34N60ha24TPmtcCT1nHZ/M3zOM8q8P50htdgE2QENM5udJkcKYyfXioZRwmzfsOP6EG8vbkT8RdI7n3GCg==
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYWPR01MB9420.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(136003)(376002)(346002)(396003)(366004)(186006)(451199021)(1800799006)(71200400001)(122000001)(38100700002)(38070700005)(53546011)(6506007)(26005)(83380400001)(2906002)(8676002)(52536014)(8936002)(55016003)(54906003)(86362001)(110136005)(478600001)(4326008)(9686003)(64756008)(66446008)(316002)(66476007)(66556008)(7696005)(33656002)(41300700001)(5660300002)(66946007)(76116006)(95630200002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?iso-2022-jp?B?aGJETERJNnJ0V0djMFBBY2I3ZzExeWxvVVNjelUvRmpVRk1DMXQ2SDVh?=
 =?iso-2022-jp?B?S1luT0IvaW1DOW9sWGZZRlVCeDFLSUU4clVYb0JtWVE5SDdidDRUd3NT?=
 =?iso-2022-jp?B?S1dFdWwwMi9Nc0tWSExjdFQ3RUR5cENRK1A2Zjl3eDd4ODRsNUduUDdT?=
 =?iso-2022-jp?B?ZlBsMEt5UHhVd05PbElvQVZLRUdDMG1QM1dlWXlONnU3elMvS3BnZjNx?=
 =?iso-2022-jp?B?MmdTcWd2TXJnRXJBWDdWcDNxUSsxZDluWWpPTTJOcDd3LytVaUNMREl1?=
 =?iso-2022-jp?B?TEdTSzlmQ2pUd1pCcnpJbjRTVGErMExNUVhpR3NORmsxZ2Nobjd5aWJS?=
 =?iso-2022-jp?B?R1IrUTBCNHliRzBmTkdkTlJ1cHhTcGJqZTNRUEF4TTNIZTFReEl0dmZ0?=
 =?iso-2022-jp?B?d1IyVDdpd2JLOWw0dG5KSUV1dXduMEhiMjJXTE5UR0duWHM2ZzdlRHhH?=
 =?iso-2022-jp?B?SG0wZncvSkd1OVlDVGxTaVNHT3FYQnFFZ0M4R1NRZzVLa0xEQzJkQ0pu?=
 =?iso-2022-jp?B?Mlk1bE13RUNqa1lkdjAvdnVnbGRMTGVCVEVMSGRoSjVCcnd6WmdCM0Rm?=
 =?iso-2022-jp?B?cEZYaGEwcHlsc3M2NGZKcmNZRFdkQi92dWJ1MFFqVlZkTVBja2lqM29u?=
 =?iso-2022-jp?B?V3N5d1pVbTE5YXBXYS8wRlpRSlVSRDYrNitQVzdVdS9nQ1lpdldpMWU1?=
 =?iso-2022-jp?B?Y0wxM080dkNjeVFlWDBxMkNoVkpUMnlhSlc5WnFVdlgwMmJuOWVDWWdE?=
 =?iso-2022-jp?B?azMxSVcyYlh5TkszZGpzMzBZS0xYYzlzbWFtUzBzMldPckkwU2t3aUZR?=
 =?iso-2022-jp?B?U3VhWlZIVko2T2Rod2tCTlQzSHhWeUZhQkk3VllpMjAxWXpnUUZ3anZZ?=
 =?iso-2022-jp?B?WEVMMDBQNVBTVlhYelVra3ZFL0FVLzM0MzFmNGk0cVZlZkl6MDJkdUY2?=
 =?iso-2022-jp?B?dXBrZ294VDNPMGFlYU1aTkk4bVdLdy9Kc3F2QXp5aS9KQ0xjL3d5Y1lE?=
 =?iso-2022-jp?B?c284RmpNR1ZnSGVUUGVwU2tjRk9EdEpRcXFPNW5DaG5YRy9vWWszdDRL?=
 =?iso-2022-jp?B?blNwRnFXY0lFMWVMYlhzR1hXWkNWbERLeGRFbWJtUk1DQWpzdmZCTEVW?=
 =?iso-2022-jp?B?M2ZiOHhvblRqTmlSN0xoOE9HdlFxWFZCQmxLdkxCVHpySU5GdEs0UzVU?=
 =?iso-2022-jp?B?UGwwTEtvemNzNzJBTDhHcWYxN2w2NkM5Kzhrb3FnQWtaRDZ0OTlzNVJU?=
 =?iso-2022-jp?B?ZXpKa2Znb0xVUmZFV3BmMGJ1Z3ZlUklBMGw3VHMrZS9jMEtlVXdPaWpa?=
 =?iso-2022-jp?B?bDc2N1lBTVcvaENmNGpLa2hPUFJVV01UZW02Z3c4MDRsY1BheFg0Z3JX?=
 =?iso-2022-jp?B?RU1aclh3WkpQb0lWUFYrNWlIbENPZGlPUTBSZlkrSmNhaDd5TEk1cjBR?=
 =?iso-2022-jp?B?U3B2cW16QWhSNEtVMFoxMUdDa3E1RnRYWEUva0xTZ01pTHZFcEFrTUVM?=
 =?iso-2022-jp?B?dERSMmd2a3dwZ05Gcnd5QkdHdUVTUnRZdjR6M24vYjhhQ1FkMUpLejgv?=
 =?iso-2022-jp?B?Y25CdXc3NTZ4RXNybHFMQnN4T0l6VWMzKzZVRCszeTl2ZXpUS3U3VkJj?=
 =?iso-2022-jp?B?RVJKbjdzaEVYdVVJcWVhVE9ZU3ZCRUFDSzJZekx5VlRrRCtoQ1pqck5n?=
 =?iso-2022-jp?B?aHpLTEJyWlcvUWxpTWVKdXVtcUtPT0NMVW5IRWdLVGtoQzV2b0ZIQ1lG?=
 =?iso-2022-jp?B?L093cFExdHBXMnlXbmo1YzNkaDRmemRkbDBERnlmemw4ZGErdGFUZFMv?=
 =?iso-2022-jp?B?eU1kMW1WTTUrc0RCL1NvRk53clpJZ0xwYnVMcTk0M3JweGNTSWpXRTBK?=
 =?iso-2022-jp?B?UUp0WGI0M2lWT1ZzNjBLeWZheitJbDAxTjdib01jSDQ0YWFnbTVaZFVi?=
 =?iso-2022-jp?B?RkVRMVlEdjc3VFo0ZXhyUXNtb1Z2dzYrcHVWQzQwRnR1OGxFSkhybjFH?=
 =?iso-2022-jp?B?bzR1SVpTdmp2UG5OZnZSNW1LUm55d2JCZWpuVGRVS1B0MDBjd3Y1L25V?=
 =?iso-2022-jp?B?SitQclRVMTRmSTVUaFBzazc5OGthR1hqcDZBcTNjcHQ1SjdPZ3ErMGVG?=
 =?iso-2022-jp?B?SGZOVTFUUHQ1R2FObU9lTTVRTmNZZUFUV2dRdThReXp3K28yNnpPTTk5?=
 =?iso-2022-jp?B?R0xhbUZvUXFiVkh2am5hSDBUZmJMTjk3YlBRc2pIaFpFS2Y2SUpYLzJI?=
 =?iso-2022-jp?B?ZzhKMmVOQWV2YXJGOTJ3Y1g2S0k4azFVK0UvcitROVpUb2I1SGtrVzF4?=
 =?iso-2022-jp?B?VnNZZUFneVhtU2xUQTNvcWxML0hGc0hKUmc9PQ==?=
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	RdTzW20qd5BD0C+SPFjfTcQO/t+VtQ7JFruRZki+nr5TpwPd3Vdp3fa5MidS9TGU5HqxuNG7Xac4azk2RxQz4zf9RRny6wZ4lEeZFLbTPwZiIFjwTVZ7QJSAemEZkL4mE7BiGZ2rfoIxUM0Jar99PzmN9jFHS+D2+Rlozg8nqWbHNaNSz1EqWPl4vAhhhb8xfdiQfNBjr95kTFu47mjJIf9xntct4nL8d7tq7GAU7lFw5cnRkrn53IddAVCxI/1/JF/8cR3wlpWZuOlVFaJZYZnK7BYZi6R/ZgZboQwEZUH3z8l4L9Jd2dcDPnLIysPReuhqAcXxiRhVbbz/XEOudnN9ypaZZdgTmBwix3HHzWdORk0vxMOvyoF7bwKkqhKD7veCZQgzK6+syUqyAblzVQeQ6okaM1w334WEyUY4dhu0F4LJfDvZoX4eYJcLcFzkeOeY1XXoRanT4JsmFauZxkV5n4sqHfsvA2og+BQqf8jxcrTocnXGRls9vawYpz1TXMCO6sarc3KPK1RtvLWQlGoK9L7Q18zNlHv2+gVwlYSytEzTYEWfXaPNtpW2qwg/v/X5XRu6673XJMklThL4IRSNWi50HEIX93X9DAjow3MIZsSJTgxa7fz8b1hNsnqtrwH5gKiIwZO6D2gV9KsnQrmSPGOTzuVeqaZA8kmNRXDa9QokFlPRbZjXfUDqfx5b5qY22hbWH41EE3kM7/VtgFi/Sx21xJwPnjOSeK9syCnFezvPByuAWlXuUDIA5B4tbiWyov5Bw4inpzFv7y7fvyvMkpjMQot5HhZvA5VTDtllBaCtjzTDv+U1LPMRhYGX/eemEAZPHPOcL0OydrqIb+bzA8nGspCZ3Bn4iBnWNH/oxukyzBfcEsrBsC+TkSfSCsKAXYZ+wY3w0QZYgrUFzQ==
X-OriginatorOrg: toshiba.co.jp
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYWPR01MB9420.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4b264632-b35f-43a7-8b4d-08db98a2905a
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Aug 2023 06:33:37.6751
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f109924e-fb71-4ba0-b2cc-65dcdf6fbe4f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: dM+Df9FSyUlfVGZIl7CoU0sIrvI+Yjm+J+roo4Nk8Tp589esg+JwqQlJxImEJi9RWDCUF7XXic/Z6IhoU8jVvptGBEKvoVH3Qt29ySj0O5eKG/V5PHZ45aIqGBN/usk4
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYWPR01MB9694
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 09 Aug 2023 06:33:55 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/12585

Hi Biju,

> -----Original Message-----
> From: Biju Das <biju.das.jz@bp.renesas.com>
> Sent: Wednesday, August 9, 2023 3:28 PM
> To: iwamatsu nobuhiro(=1B$B4d>>=1B(B =1B$B?.MN=1B(B =1B$B!{#D#I#T#C""#D#I=
#T!{#O#S#T=1B(B)
> <nobuhiro1.iwamatsu@toshiba.co.jp>; cip-dev@lists.cip-project.org
> Cc: pavel@denx.de; Fabrizio Castro <fabrizio.castro.jz@renesas.com>
> Subject: RE: [cip-dev] [PATCH 5.10.y-cip v2 00/13] Add RZ/{G2L,G2LC,V2L}
> MTU3 support.
>=20
> Hi Nobuhiro-San,
>=20
> > Subject: RE: [cip-dev] [PATCH 5.10.y-cip v2 00/13] Add
> > RZ/{G2L,G2LC,V2L}
> > MTU3 support.
> >
> > Hi Pavel,
> >
> > It seems that the following patches have not been applied in
> > 5.10.y-cip tree.
> > Do you forget these? Or do you have a reason?
> >
> >   arm64: dts: renesas: rzg2l-smarc: Add support for enabling MTU3
> >   arm64: dts: renesas: rzg2lc-smarc: Add support for enabling MTU3
> >   arm64: defconfig: Enable Renesas MTU3a PWM config
>=20
> These patches are from next. For testing I have added here.
>=20
> Pavel wants the patches to be picked from mainline due to CIP policy reas=
on.
>=20
> We need to wait for another 2 months to get these patches hit on mainline=
, So
> that proper commit ID can be applied in backported cip patches.
>=20
> Commit-IDs in next can be changed while applying to mainline.
>=20

Thank you for the explanation. I got it.

Best regards,
  Nobuhiro


