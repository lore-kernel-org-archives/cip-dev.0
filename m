Return-Path: <nobuhiro1.iwamatsu@toshiba.co.jp>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E352C433EF
	for <webhook@archiver.kernel.org>; Sat,  4 Dec 2021 23:24:34 +0000 (UTC)
Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.157])
 by mx.groups.io with SMTP id smtpd.web11.31416.1638660272326385612
 for <cip-dev@lists.cip-project.org>;
 Sat, 04 Dec 2021 15:24:33 -0800
Authentication-Results: mx.groups.io;
 dkim=missing;
 spf=pass (domain: toshiba.co.jp, ip: 210.130.202.157, mailfrom: nobuhiro1.iwamatsu@toshiba.co.jp)
Received: by mo-csw.securemx.jp (mx-mo-csw1115) id 1B4NO9hE000736;
 Sun, 5 Dec 2021 08:24:09 +0900
X-Iguazu-Qid: 2wHHuF5L5bfJJ11nHs
X-Iguazu-QSIG: v=2; s=0; t=1638660249; q=2wHHuF5L5bfJJ11nHs;
 m=YLsK1JqPJWoiP3IzxX0fmjOVH+S66CVIRcSd0OQchr0=
Received: from imx2-a.toshiba.co.jp (imx2-a.toshiba.co.jp [106.186.93.35])
	by relay.securemx.jp (mx-mr1111) id 1B4NO4Sh034004
	(version=TLSv1.2 cipher=AES128-GCM-SHA256 bits=128 verify=NOT);
	Sun, 5 Dec 2021 08:24:05 +0900
Received: from enc01.toshiba.co.jp (enc01.toshiba.co.jp [106.186.93.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by imx2-a.toshiba.co.jp (Postfix) with ESMTPS id AF6921000B6;
	Sun,  5 Dec 2021 08:24:04 +0900 (JST)
Received: from hop001.toshiba.co.jp ([133.199.164.63])
	by enc01.toshiba.co.jp  with ESMTP id 1B4NO48N011575;
	Sun, 5 Dec 2021 08:24:04 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aGH/j8WdF4/jbwbxF/8vVgHzH1txrMHqXgruZcAeSU1Vat+Eog1JfPrl2hvotiLyNnAOi6kqC7s4wIoosKTq5Goc2Rr1GjVdEUD9jjs8gGqpz2rxxCez0BXXkViMo6w2/BXwb83qDhNV0E5GGIeLFIciwp0M41ns3V53qN/A1uJ4SFNLQY2xrXkZVmsalc5+x6izdsne73iTXNUDGQM4bCOlESsDhpXkIO4MLriAUX2/9xkHNBqv0/39w+2jHyrnmQhMScfQkH3EVmVFplouSExryo2q3VCTAaQwTIObtlhEHtmkqBiOrWtTpPp9Ys07tqnw20oGc4WlLx1kFsutxA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cXFXVpvF7Lxct7D4TS5ZC7D9qtMr/3L5lw/4xRNc+Pg=;
 b=IO9JuV4CUCREI2cITvDnZ9Woe4XCllebtnFWd1s2KoTx54hYiPG+od608pg+mHTRbDSSOSS1/IpFxXHL3+baOEu+y4ZyUK5jsWJe0atDvVXlOAE9y+naYcOmQYMB6YFSoH1Agf/iLrKxcaIyr9vv44hQ5sr/X8JsyhhaOACMo4Od7dneh88589uyozENX0Z0yg7DQ+PbPXle0ISKoCJ3Zj4FtOrI4iA7Qc0snXrC0I1qRt+ruJNtTHmjVWl9jiq6MnWgYTLjEf+DXvU7BQu+gS9zv3nzLUeeGVBA0TuNDcD5Cz0WYsZtP5tzyMXjhKx9p3jVy3u/9fJa/jntXapyzw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=toshiba.co.jp; dmarc=pass action=none
 header.from=toshiba.co.jp; dkim=pass header.d=toshiba.co.jp; arc=none
From: <nobuhiro1.iwamatsu@toshiba.co.jp>
To: <cip-dev@lists.cip-project.org>
CC: <jan.kiszka@siemens.com>, <pavel@denx.de>, <Chris.Paterson2@renesas.com>,
        <masami.ichikawa@cybertrust.co.jp>, <uli@fpond.eu>,
        <alice.ferrazzi@miraclelinux.com>,
        <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [ANNOUNCE] Release v5.10.83-cip1 / First release of the CIP 5.10.y
 Linux kernel
Thread-Topic: [ANNOUNCE] Release v5.10.83-cip1 / First release of the CIP
 5.10.y Linux kernel
Thread-Index: AQHX6WWFFxrA+5eQK0Gi5dNX/WbH9A==
Date: Sat, 4 Dec 2021 23:23:51 +0000
X-TSB-HOP: ON
Message-ID: 
 <TYAPR01MB62524C420EECB609794B0587926B9@TYAPR01MB6252.jpnprd01.prod.outlook.com>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
suggested_attachment_session_id: 55835aab-e7b3-8413-59ff-468c039b8652
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=toshiba.co.jp;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 2459eddd-76b3-4bcf-08bf-08d9b77d21c4
x-ms-traffictypediagnostic: TY2PR01MB2283:
x-microsoft-antispam-prvs: 
 <TY2PR01MB22832157DB5476DDA1585ED9926B9@TY2PR01MB2283.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2512;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 iZhqxrqxxaiOH7EjN2fy20SSUj3NCgav2YQ+6nJZyiaZJgh2DRjMsynx4CkifDPpOFsN5rFrJVV5dV6e7NjGvCM3Ln47SKAPnN0PzIz6Xkb7JRrLcPwewxykT5RZMqFn4onARw/PThqsrnb8biiV0TLUSNNyv039eklSMnevJXnQDELoX15xzyzR5wkBCkt4O1lQfUEELuPrpdGNLWrGEC13nEcNyOC6Mq0PKEw35EBXm5sr+flWgYrz1Du5W7mX2UalHHpW2idX+lAzL+3V//Nhf9ebp+Ba8XHWR4iOqzFCWVZKLoITP62qD12AuKzw6aZmv1J5icKZGD+vXmRlkRNm0KsxTdQGom+yin5tqEKT1xB/qCeTjxNO6RuEwbDNMUDUlxqqj88WrHR8PImUShRNZKO8x8UgO4WYE+BHiHUPpXhPBwbz7T9OGBIjVybCe41fcsvfj5kz5XF095L87zDXTqLpVkNkb9ZqlhJDOOngYx+QysvWt/Sw2xa2MoIHQ1+GJp8FL3Uahb7Fnl8fPZRwi5ZVXaI7L6s0jLlMo6vrVrNxKfSktaZGJmybbvmTvJnNEu2eBxWP9DOgv6lYHg3u4rqhd5z0Ryy2XR+gEwfqUmxctnna7MZRP7q7JL9xxXjX3rY5fvJ/NtRbytp+IPrjmU18dCwuSYdfBiKnEmI44xydpyI8+vGBJB8ApcOrHrtdteN97JYbH8DoIznNWzOEcoG7pCTCmoqmU/oXtXQDsoRv6G+j2Lk8s6OuT/OTonz86wCamGo1IIxjlOzBcuPsBn5T9MQtx9IBT2rRmGI=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYAPR01MB6252.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(33656002)(6916009)(2906002)(52536014)(9686003)(38100700002)(83380400001)(508600001)(26005)(54906003)(6506007)(8936002)(8676002)(4326008)(316002)(186003)(38070700005)(55016003)(5660300002)(71200400001)(966005)(76116006)(7696005)(122000001)(66946007)(66556008)(66476007)(86362001)(66446008)(64756008);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?iso-2022-jp?B?MjM0bDhpTlVYUzRMa3AvSDE5UEY0K0lxamIwa1liOSs5bzRydUJDanh4?=
 =?iso-2022-jp?B?OEdlMnE2MGpWU3ovZWZFbmVoL3FXY1FscVFscE1YczJ5ZjE1elZwOXMz?=
 =?iso-2022-jp?B?R3NHaTd4VHQ2QUl5MlFoeGw3M1dpQXhTWG5LdFZrY0xyS2RRRGJHNGV2?=
 =?iso-2022-jp?B?M25zeFBkY1BXbFBHOGxsdFNSM2JOMHNmYXlvWWtRZDZvZFZ0T2hQRmRH?=
 =?iso-2022-jp?B?TW5mL2QyNzkwYmtZTW9JelhkQW5vanFOV3R4aHZUbmQ4TDdhbC9kRXB2?=
 =?iso-2022-jp?B?bFNnVVd4QzFpQWsvZFB1Q05CbE5mS3RHTnc3MDlJTHBKbElRRHVxTE9l?=
 =?iso-2022-jp?B?OUQxM01OUWpsb01JclZEVHRHdDFqTTliSWNsV0xyRzU3aGhWWnpobG5r?=
 =?iso-2022-jp?B?Nm5mQjBEN2ZKSDcvbVk1MXNjd3dDYzJFQUxPUms5dEJFNXZjb1g3THlV?=
 =?iso-2022-jp?B?NGhTZWZxeGtpbkFBQ1FOSVBHL0F2VzJCMHJSVjArOTI2UzI5UGhnZTAy?=
 =?iso-2022-jp?B?U2RtYjVJdUE2LzdKRno2bVpReFR1S05FOGs5YmhLQ1FrUUZKNjJFYTdD?=
 =?iso-2022-jp?B?UW9KaFd1QXJWWkoySWh0M0U5VDhCbmNYbEU0MTBQNHljOUhBaXBBZDFG?=
 =?iso-2022-jp?B?LzkvTzR0QURUWEdsWVNsVW9HcWZ6cWw4SXZzdkd5d2xkTHNOMmROMzhk?=
 =?iso-2022-jp?B?SW5OYjNjRmlNK3k0d2NqcStTRXpGWUwwWm5iWjZ4Znd6RE94bnNpRThz?=
 =?iso-2022-jp?B?cW9NZGk0QzRwN1pUT1dhczJqOEthZ1Q1aWg3b0I3eGNzUW1jbW1rRjgy?=
 =?iso-2022-jp?B?Q0ZoRks2Y2JWQjhXTWZlSnJIUmhIVHJMQjRzS2UyMW9lUy9EYkRmcDNt?=
 =?iso-2022-jp?B?TVlEdTlQTHZhbDE4ZHhwTUVGTFVvMkhianRTY2JVamlaUGQrbXoyVklK?=
 =?iso-2022-jp?B?TzREa3lacmNmVWgrcUVEcmZKS3NwZUdNRis2bVhmZ01JcXFNdThZUGJQ?=
 =?iso-2022-jp?B?YVg3b2h2OEN6WU81TlZmdlo0RWtGOW14M3FSSlYwL0tGWS9JNytUenRx?=
 =?iso-2022-jp?B?UUs4WDM4Y2pHMDBPN2twVXBPZlhmY2dwcVFBdXJadE9senllSi9FRlpm?=
 =?iso-2022-jp?B?OVM5cTFiaDcrcDVmYmNtbkRYcDFSZHhIU2VEeTdSSTBGeTUxdEdHRXZR?=
 =?iso-2022-jp?B?Q3lhdVljV0tZWmdrSTI5WWxCL1NpOWJTK2dScTIwMExlZHdxbDM0ZFpJ?=
 =?iso-2022-jp?B?WUFvZHBsdXJ6bmg5VS9DbUYrUGh0M2w3Q1dPNXVHZEs2UklCcHdkbzZI?=
 =?iso-2022-jp?B?dmp1dEpnNGN6bC93QkRCR3RrSCttcG4xUkNZVXV6YkRPcS9xeGZmcTZl?=
 =?iso-2022-jp?B?bUZhMld1YVlKUDFQL2s0QWVRVWxGclFndmRmRXdqdiszR0FrY0kxeG5N?=
 =?iso-2022-jp?B?ZUY1WGFhY1huR1gxdnNSOE9yclMrYXVlMEMzSjRWb0Y5WGRueWZBa2lY?=
 =?iso-2022-jp?B?UE1Qb0hXbEtnZmRFeXpjR1dHeDFOMmkyNWlLQUNBOUhVT3E5WGJNWnFq?=
 =?iso-2022-jp?B?QjRUQngyKy9Rc1BLN0I1aGtmdEt1TjBEMVlTUmNCeUh6QjBlRGJIV2lE?=
 =?iso-2022-jp?B?aWtXQStNbG5RVnkxcHRqZk5OZE12WkhOcWpTYSthWDZ0R3MxeGV3MTUr?=
 =?iso-2022-jp?B?Ym1ZeitEZUd5ZnpObzZjVEV4R0t6WVpyRjNCY25Nekl2NjhKSFNObWpW?=
 =?iso-2022-jp?B?d3FIMjUyNHNwaHRNUWRBRlAwNTNxdUtqMU0zMFFyaGhXaytteTdZRGxz?=
 =?iso-2022-jp?B?WDRWM2NqMDdjUEVCeHNnSldPeXo5eEs5cjcrakVGOTMvSTd5WkZWaTN6?=
 =?iso-2022-jp?B?QUF2MU9jNXJmTmw3dUp1RlVtTnA3QytRMWRxckppZVBsNkhSMEp2UGxY?=
 =?iso-2022-jp?B?emRoNkJnbFV6eFNzTVYzS0xsWXUvMjNna2pDWjRCc0ZINkU3cVY5blVP?=
 =?iso-2022-jp?B?WklOZjFWVXhvV1BYa3UzMEpsVU5HcjZVSysvcGNyMGswcDVoVzdSNFo5?=
 =?iso-2022-jp?B?VmpNZ0FiM1VrbG5qMHRUS3pwQ0dhbHQveVdYcGxxRzVUWDRXOTR4dGRr?=
 =?iso-2022-jp?B?eEVmTjZaby9mL3doT2NOdWkwbm1PbzdkZEdUbms2TUY0dFZBZGx1d2ZI?=
 =?iso-2022-jp?B?SjhrWkZ1UGFvZzh2cHBDUTZkcGxxcmVpN0I1WEtpRVhWRVBwQ3hxTnpG?=
 =?iso-2022-jp?B?OFQreWgzRGxxSjE2bmNPVUEyeTNrL3Z5d1NJMk1pZ01SazZTU0oxbWY0?=
 =?iso-2022-jp?B?cHpBY2NxWlByenRuVDkwTUl5ckpPV0RMYVRCd01sTWlXbXBDa3VFVVBi?=
 =?iso-2022-jp?B?M0hiT2ZJS1d5SHlZeVo5Vjh3UDVFNDNxWks4L0FNWlhObkpQNE5CZHl4?=
 =?iso-2022-jp?B?ZXZLNmFXKzBqRTFDR3YwaHZHTFYzcEViWDF0ZG1kS1Z2YzJpV0dsdGFX?=
 =?iso-2022-jp?B?R2EvSlpO?=
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYAPR01MB6252.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 
 2459eddd-76b3-4bcf-08bf-08d9b77d21c4
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Dec 2021 23:23:51.4099
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f109924e-fb71-4ba0-b2cc-65dcdf6fbe4f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 
 3EqStvWAqgjIkz/9DPx18EX29BSK+hH1BGl+zewXjEfgenDUADHIf4po6MJRzE8gqkvolFfC1cBBlmCM6Nb8Crzoh1yvv9ZP9VKsYA7waOBCdUqfwJBwn/9ufe8uPOEg
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY2PR01MB2283
X-OriginatorOrg: toshiba.co.jp
MSSCP.TransferMailToMossAgent: 103
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Sat, 04 Dec 2021 23:24:34 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/7061

Hi all,=0A=
=0A=
We release v5.10.83-cip1, which is the first release of the CIP 5.10.y Linu=
x kernel !=0A=
This is based on v5.10.83 with some additional updates for the Renesas refe=
rence=0A=
boards.=0A=
=0A=
You can get this release via the git tree at:=0A=
=0A=
  v5.10.83-cip1:=0A=
    repository:=0A=
      https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.git=0A=
    branch:=0A=
      linux-5.10.y-cip=0A=
    commit hash:=0A=
      2332f07a324fd78d7c7436deeed23cd7db441ea7=0A=
    added commits:=0A=
      CIP: Add a number to the version suffix=0A=
      dt-bindings: pci: rcar-pci-ep: Document missing interrupts property=
=0A=
      dt-bindings: timer: renesas: tmu: Document r8a774e1 bindings=0A=
      dt-bindings: PCI: rcar-pci-host: Document r8a774e1 bindings=0A=
      memory: renesas-rpc-if: Make rpcif_enable/disable_rpm() as static inl=
ine=0A=
      spi: spi-mem: Fix passing zero to 'PTR_ERR' warning=0A=
      clk: renesas: r8a774a1: Add RPC clocks=0A=
      clk: renesas: r8a774b1: Add RPC clocks=0A=
      clk: renesas: r8a774c0: Add RPC clocks=0A=
      pinctrl: renesas: r8a77990: Add QSPI[01] pins, groups and functions=
=0A=
      pinctrl: renesas: r8a77990: Optimize pinctrl image size for R8A774C0=
=0A=
      pinctrl: renesas: r8a77951: Add QSPI[01] pins, groups and functions=
=0A=
      pinctrl: renesas: r8a77951: Optimize pinctrl image size for R8A774E1=
=0A=
      pinctrl: renesas: r8a7796: Add QSPI[01] pins, groups and functions=0A=
      pinctrl: renesas: r8a7796: Optimize pinctrl image size for R8A774A1=
=0A=
      pinctrl: renesas: r8a77965: Add QSPI[01] pins, groups and functions=
=0A=
      pinctrl: renesas: r8a77965: Optimize pinctrl image size for R8A774B1=
=0A=
      Add configuration for gitlab-ci.=0A=
=0A=
Best regards,=0A=
   Nobuhiro=0A=
--=0A=
Nobuhiro Iwamatsu=


