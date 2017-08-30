From: jan.kiszka@siemens.com (Jan Kiszka)
Date: Wed, 30 Aug 2017 21:06:01 +0200
Subject: [cip-dev] [PATCH 04/25] serial: exar: Fix mapping of port I/O
	resources
In-Reply-To: <cover.1504119982.git.jan.kiszka@siemens.com>
References: <cover.1504119982.git.jan.kiszka@siemens.com>
Message-ID: <48df65a0495eeeb0ee762fe00bf96b756642cc47.1504119982.git.jan.kiszka@siemens.com>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

From: Jan Kiszka <jan.kiszka@siemens.com>

commit 24572af4fb6ce0726dbe12b0286de11d25ff008b upstream.

pcim_iomap_table only returns the table of mapping, it does not perform
them. For that, we need to call pcim_iomap, but only if that mapping was
not done before.

Fixes: d0aeaa83f0b0 ("serial: exar: split out the exar code from 8250_pci")
Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/tty/serial/8250/8250_exar.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/tty/serial/8250/8250_exar.c b/drivers/tty/serial/8250/8250_exar.c
index e6b44a75a5e0..58469d9d6515 100644
--- a/drivers/tty/serial/8250/8250_exar.c
+++ b/drivers/tty/serial/8250/8250_exar.c
@@ -72,6 +72,9 @@ static int default_setup(struct exar8250 *priv, struct pci_dev *pcidev,
 	const struct exar8250_board *board = priv->board;
 	unsigned int bar = 0;
 
+	if (!pcim_iomap_table(pcidev)[bar] && !pcim_iomap(pcidev, bar, 0))
+		return -ENOMEM;
+
 	port->port.iotype = UPIO_MEM;
 	port->port.mapbase = pci_resource_start(pcidev, bar) + offset;
 	port->port.membase = pcim_iomap_table(pcidev)[bar] + offset;
-- 
2.12.3
