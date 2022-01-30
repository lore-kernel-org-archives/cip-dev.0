Return-Path: <nobuhiro1.iwamatsu@toshiba.co.jp>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E85AC433EF
	for <webhook@archiver.kernel.org>; Sun, 30 Jan 2022 10:06:39 +0000 (UTC)
Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.154])
 by mx.groups.io with SMTP id smtpd.web09.17298.1643537196891289346
 for <cip-dev@lists.cip-project.org>;
 Sun, 30 Jan 2022 02:06:38 -0800
Authentication-Results: mx.groups.io;
 dkim=missing;
 spf=pass (domain: toshiba.co.jp, ip: 210.130.202.154, mailfrom: nobuhiro1.iwamatsu@toshiba.co.jp)
Received: by mo-csw.securemx.jp (mx-mo-csw1515) id 20UA6FBL026720;
 Sun, 30 Jan 2022 19:06:15 +0900
X-Iguazu-Qid: 34tKGzSFLcRDzdANI8
X-Iguazu-QSIG: v=2; s=0; t=1643537175; q=34tKGzSFLcRDzdANI8;
 m=1OXGIbW2kMnicnCqDG0fOIffAOyNJ9NuaoRQuolTHYQ=
Received: from imx2-a.toshiba.co.jp (imx2-a.toshiba.co.jp [106.186.93.35])
	by relay.securemx.jp (mx-mr1513) id 20UA6CEC020777
	(version=TLSv1.2 cipher=AES128-GCM-SHA256 bits=128 verify=NOT);
	Sun, 30 Jan 2022 19:06:12 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nhqxTpYIuwiItOoutLT7SAS1f2hdi4pt2xDZcpcEHPW3FPGpoW/bvoXU6cSwNcbFHStBp9ycMXkXUIIc9j6hJZDbzOswFtHtRONkDG16DSmSc9LfaPqoite1AZyNdJR4oUHLRcoO/WQMRnEL3J/xo5dMMgwis6EKFDESjCV3pgWHJMsrWTV0eptsC49WjapSZdJvrO0kvzafwq/mdyYMlhxuF+UBiHKwGPn/XWwa+VCBTzyDkU2ZsZpbx3vwDn8w9DZmf08CINFhuVClNMettAuBYLAv88yqf8Zt1JFlHM7+U4KQP8m5zKWt1Ku3iDix9lVAIqgwymoGu5bfctMnVA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5+KaVOVSc1T558UPyj9oUrYRnpx0VN9qZFWgTFtWwcA=;
 b=GifjP8ji1wGsZh9ZkRV3P10tTye6yM74tpKYvx1906DeK/oGowN6HskcPecjdNUWixUpC0+OP48gSUv72S8wx4QB3/r0F9sT6Z0vWAk2taA/Q3OIEvDdskyKRCNarAa3AFCmtEkohLzjPVpplNRvkhUtwaf2DFJsGIsYhJa8HVISaWnLPtKU+7Tjxd/ogJ5iw3Qi30NL+yCFceScwVdK84sfNXnYmygWAOAy/plSJxpuC+iz2iuJDt/LdvSt40h59cQustVSmIsYrbBqSvCC3MkUino/AzF2RJetp/gNlIF2qGaj6xK3+L/E6BvYdH/Dph+phTL6+Y69wuflaU+IFw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
From: <nobuhiro1.iwamatsu@toshiba.co.jp>
To: <cip-dev@lists.cip-project.org>
CC: <pavel@denx.de>, <uli@fpond.eu>, <Chris.Paterson2@renesas.com>,
        <jan.kiszka@siemens.com>, <masami.ichikawa@cybertrust.co.jp>
Subject: [ANNOUNCE] Release v4.19.226-cip66
Thread-Topic: [ANNOUNCE] Release v4.19.226-cip66
Thread-Index: AdgVwM9OMP5HdRWPT5GZYq1cbTDsjg==
Date: Sun, 30 Jan 2022 10:06:10 +0000
X-TSB-HOP: ON
X-TSB-HOP2: ON
Message-ID: 
 <TYAPR01MB62529A861E99DC7B883E3C0192249@TYAPR01MB6252.jpnprd01.prod.outlook.com>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=toshiba.co.jp;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: bff3e364-4b7d-42bb-d76a-08d9e3d823d1
x-ms-traffictypediagnostic: TYAPR01MB2063:EE_
x-microsoft-antispam-prvs: 
 <TYAPR01MB206365840354413495958A2C92249@TYAPR01MB2063.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:393;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 EUbYw4u73gvwyNyfsXSHVHlIbkR/dK9QzXmTVV4/nfkpNg9vDVxvRMbfvxFwqYB3MTiJCDXag79UtceVtGZvVZl87rHvVvwrDwGtU15ieJHbOo6CbTQLnxWv9OIBar3pceA78TtJiYqt5MIB7qJ+FC+jJiw5Pzfl/zhf60A6wwv93wzrAQhYhUZlF3pjdzJOqMj+pMcR1QpTyviL4g7YKOiTa33mfPnyeLDk4hsTwxJgc+5z9ddyRcy3qBBcOEml1TUi2YAWihmZA57BMpbpRC/y8II1SipB47jK29Lq+8jJCJNsJOy3r3K3l7v/V4B73klBpGzWHEQgVdtD8hpV25+8Zjib6V1UceWGtOOfB1ZDg/eXu3TY5uAh+ispWrbfmGTadmdYq4VawN0vzy7Jg5YjVM6/EqqhLywWUIOvh9YeGPZ+Rf2/b919mlx24RDPDQj9QOn0kD9gvRdprz55qHkgNqEkEtAB4oIJafQrOKq6ux10hmpdOqrJDKnqrvr1kaEOD8df2aDte+sjBm7NE4XT91ddeOtJpjbToMBIQLG4lRoKhjdNMmcjxCUWDb4AwN0zNVz9Zdkz97QAojBi+QiW1UkyA3ykRXDI85xqzXeStappKmaOjyID9J+o7tPSvsZmC9RSBVOre4N/5Y5l5SuWuey52JVSgizJAMp0lP+VuZpZ6ewvABwReukbnEuK1KZXDXIA86pXu5z4iOPXJHhIEaR+Dj5OsBm66gLBOVUwGEYJ6149zCNA4HaiYIYycmINr/kqI+jefmzsuuLP6gsAleLV6pk/h4RUDD4EKDg=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYAPR01MB6252.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(508600001)(38100700002)(54906003)(86362001)(55016003)(316002)(6916009)(33656002)(5660300002)(6506007)(83380400001)(966005)(8676002)(122000001)(66446008)(64756008)(71200400001)(186003)(9686003)(26005)(66946007)(8936002)(7696005)(4326008)(66476007)(66556008)(52536014)(2906002)(4744005)(76116006)(38070700005)(20210929001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?iso-2022-jp?B?T3pGN0NkR1ZqYjU0REl0a1BIazZvcjIrTng4K01hL2pOSXZpK2hmTGZ6?=
 =?iso-2022-jp?B?dHA4Q3krLy9xRG93SmNCQ1BEUDQyMXZEWS81SVZJN1BWeThYVitJSy9S?=
 =?iso-2022-jp?B?S1h4Ny9nRzhJOUpzQmRJVlkvN0hVME1rYWZsTFl5THhlczZEcnJKQi9Y?=
 =?iso-2022-jp?B?YzE3N3JHMk83RnB1dmJ1eGFMc3NUMmxYbU9OcHRISmMyOUZNSGdHZGxO?=
 =?iso-2022-jp?B?ZGRnV3JjM2dSNTNONEY3SVkzS2JyeTlqSGNmd1BPaVpNQnJ1Uk1zb01J?=
 =?iso-2022-jp?B?RUkvbm9wMitsd2g2bHhjejc0aXNLazBKUU0rOXlwOG1Eb2luSnNTTERy?=
 =?iso-2022-jp?B?YXlPN1I2S2J6VVBWMXVwSjNJeGIzQnNqTXJ0aytiY010ZHczU2REL1cr?=
 =?iso-2022-jp?B?ZlBLZHZqZitNOGpRQklSeEdWWHdHY1ZMeFpJVFk0VjVXYkdXdHZzOGVo?=
 =?iso-2022-jp?B?cE01Y0Y0R0pheXZ3V1ZlK3NYL3YvRzVYdnYxanFmMUpkTnNBSWRvZGxJ?=
 =?iso-2022-jp?B?WVkvUWViQndrdlZ3Vmx4T3ZrQUo1NVhQRFQwdnE3SEZqeVRKdTdIekhI?=
 =?iso-2022-jp?B?dGJCbE50Z2FPenc4N2tDeHREcWhCS2FRMkZ4SGk1WU1vclZFSkYvUkZF?=
 =?iso-2022-jp?B?LzdXeU1WQkZPak5wTFZ3WnZtZjVWRWxHa013S1J3Ti9IY3BzcmxpdTFB?=
 =?iso-2022-jp?B?U09TS1FvUEwwb0R3ekdES0JEVFhVSS8yQTE0UFdJK0k2UXEyeWVwbXNI?=
 =?iso-2022-jp?B?ZmZITFhuOGVmeEhIczBQOTI3VkVzUE5pMGRJWGlVY3RIRmh4ZFN6OG5G?=
 =?iso-2022-jp?B?TURXY2txVGVKamMvTmtjcmVkMTE1RHBVa2tjSHZqWStzbW5leERpbGk5?=
 =?iso-2022-jp?B?Q080ZDN1RzlCZkZINnJEMEJxa1ArWlRJSlVOUzJGNXp0Nkd0eHVVL1do?=
 =?iso-2022-jp?B?dm5aakNCUUIyVExIY1QyR0ZINXNIRk16YStHd3l5OStJOEVsUEtJeCtt?=
 =?iso-2022-jp?B?WUtBaVo5OHJVZVpXUjZEbjZtVTVhNk9rajBTN3ZiVjBFeGxmRnUxTU5t?=
 =?iso-2022-jp?B?cWFEaWJ4ZEF5VmJpZFNTYUw2U09nVGl5ZFI3R201WUt6MmlCcDlqcG9i?=
 =?iso-2022-jp?B?TW04NnIyZ0ZDQy9DcGEvV0hnQXhqRmM0NmFyY2JnR3hZbVRVUGFiWXJJ?=
 =?iso-2022-jp?B?NFZJQjVacGtRRlB0N2RRVzU4TGk3UEJXRkV0ZStBSjhSdzRSMDZaSmV3?=
 =?iso-2022-jp?B?NlExbGxsbVRXc002RzRaV3BJeldCNXhZVndleHNNYzhkRWkyMUFpZzJi?=
 =?iso-2022-jp?B?aVpncWtyTEVmSUR5dEJkSmtUSEdta2hHT1VEVXE0Rkd3RnJVSVgvOEJE?=
 =?iso-2022-jp?B?WjJpZ2ZWbWt6Q2kzN0ZqMVNNdmtZTUhPa3lCNUFFVWhpdkdNWGo3TDVE?=
 =?iso-2022-jp?B?T1UwaE12SjZCeW1IODkwSzVMSHVlN01QdmlUOGR2TXBPUGd5a0hRR3Bh?=
 =?iso-2022-jp?B?eW40d0xXd0UvNXVOV3NHY1NsOFpSZ0xTbk9IL2Yxb3VPTUJoTGNHWVpp?=
 =?iso-2022-jp?B?R0lpMGF5MlRSZ0NTaEV0VlQxMnVBaUI2M0VMc2pwZTVBOEs1clUrcmVT?=
 =?iso-2022-jp?B?WWhZZmJqcUpOUnl0VytoTGoxQ1pTd3JBRW54YUhZb0JNTGdtdC9zdEoz?=
 =?iso-2022-jp?B?NVZEWnp6TWVPcmZ2TE5wS3lySnZybmVmUmNCQjNTb2xCZmhUZ2c4OUJB?=
 =?iso-2022-jp?B?Y1l6UnBJM3IzTmFuV1pwSHFyL2dvZmFpZXFiMWxGdXNlMW02MFpMdHQ0?=
 =?iso-2022-jp?B?dzcrODVRY0lQR1lpNWRpNU81TE5pVGdJRlg1MzNYMW5TL2JEL0EvODBX?=
 =?iso-2022-jp?B?dTduVFpnK0dROFJ5TFBNb1RiekgySWYzczMwUTY0bmR1Q09TVXFjNmZL?=
 =?iso-2022-jp?B?Vlo2bGptNUxIK3VXMlJGMkQ0cHE2ajZPOHNxTk5mVU1TRmtNb0hTcXE3?=
 =?iso-2022-jp?B?eUNZNTlxRmFSTGExS2k2WEpHaVZNV2ZhWTZ2Y0tBek9iaWZnQ2IxaDJX?=
 =?iso-2022-jp?B?TzJuSXF0ZFBNZTlHeThyVlNEWVY1ZlZuUTRuMTRTM1l0VFNNRDFFNzZl?=
 =?iso-2022-jp?B?MjRHdlBwT0JZNmdwVUV6R3oxRkhSclRxK3RKN3M5d2ZuZEROc0lRTW5W?=
 =?iso-2022-jp?B?ajdMeC9zeE54WXpyL1Rva3V1Z0Y5Y2lCNUgxS2Q2QUN5S3JmMCt6cUxI?=
 =?iso-2022-jp?B?VmxQNWVXbGlicVlrajE5MWw1WG5xKzR3R1pEY3hsWUNFR2dCa3NhUVJN?=
 =?iso-2022-jp?B?bnNaVVREOWdMS0c5c3FxTEFHTUpjRk5UOFNuZ0VVUW4vSVorTmQ4MGlE?=
 =?iso-2022-jp?B?Ykp2RjdrbWI0bDhvTzdFdjRyNEhreG9OZHRFV3ROQlNoYThPb2hlaENz?=
 =?iso-2022-jp?B?Q09nRHNCSlo0MzRqL3F6K3c5dENIeCtER3NmZ3d0Rk9ZZW5YbnZPNGpE?=
 =?iso-2022-jp?B?T05QWnJiSkJTYnBBUXhEZHIrVTB0ZmhxamttZz09?=
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYAPR01MB6252.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 
 bff3e364-4b7d-42bb-d76a-08d9e3d823d1
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Jan 2022 10:06:10.2406
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f109924e-fb71-4ba0-b2cc-65dcdf6fbe4f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 
 XYO736gxGBlX+4WE+J9Lc+wybVJ1MVE2IyHi7jN4Ximn6UKIGu0hkyK4zUMQ40yqStIlMx+0twe+IOQ8aNeOtQdVvWqgJo5Gz+lvhgUh5f7ExHHgKJU/QTOBIAwV54ci
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYAPR01MB2063
X-OriginatorOrg: toshiba.co.jp
MSSCP.TransferMailToMossAgent: 103
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Sun, 30 Jan 2022 10:06:39 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/7519

Hi,

CIP kernel team has released Linux kernel v4.19.226-cip66.
The linux-4.19.y-cip tree has been updated base version from v4.19.225 to v=
4.19.226.

You can get this release via the git tree at:

  v4.19.226-cip66:
    repository:
      https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.git
    branch:
      linux-4.19.y-cip
    commit hash:
      7eac607239ce3ce7e0e12a2d5c9c6baadc0e5369
    Fixed CVEs:
      - None
    added commits:
      CIP: Bump version suffix to -cip66 after merge from stable

Best regards,
   Nobuhiro


