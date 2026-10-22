Add-Type -AssemblyName System.Drawing

# 1. Definición de rutas absolutas
$baseDir = (Get-Location).ProviderPath
$targetFolder = [System.IO.Path]::Combine($baseDir, "Images", "Ribbon")

if (!(Test-Path -LiteralPath $targetFolder)) {
    [System.IO.Directory]::CreateDirectory($targetFolder) | Out-Null
}

Write-Host "Directorio destino: $targetFolder" -ForegroundColor Cyan

# 2. Catálogo completo de las 64 imágenes
$iconList = @(
    # --- Facturas y Entradas ---
    @{ F="InvoiceNew_32.png"; S=32; C="#1D4ED8"; T="DocAdd" },
    @{ F="InvoiceDirect_32.png"; S=32; C="#1D4ED8"; T="DocBolt" },
    @{ F="Quote_16.png"; S=16; C="#0284C7"; T="Doc" },
    @{ F="Order_16.png"; S=16; C="#2563EB"; T="Doc" },
    @{ F="Proforma_16.png"; S=16; C="#64748B"; T="Doc" },
    @{ F="GoodsReceipt_32.png"; S=32; C="#D97706"; T="BoxIn" },
    @{ F="PurchaseOrder_16.png"; S=16; C="#D97706"; T="Doc" },
    @{ F="SupplierInvoice_16.png"; S=16; C="#7C3AED"; T="Doc" },
    @{ F="Transactions_32.png"; S=32; C="#0D9488"; T="Arrows" },
    @{ F="LateFees_32.png"; S=32; C="#DC2626"; T="DocAlert" },

    # --- Captura de Transacciones ---
    @{ F="InventoryAdjust_32.png"; S=32; C="#2563EB"; T="Sliders" },
    @{ F="Transfer_32.png"; S=32; C="#0284C7"; T="Transfer" },
    @{ F="CashRegister_32.png"; S=32; C="#334155"; T="Cash" },
    @{ F="CashAdjust_16.png"; S=16; C="#334155"; T="Cash" },
    @{ F="Bank_16.png"; S=16; C="#1E40AF"; T="Bank" },
    @{ F="BankDeposit_16.png"; S=16; C="#1E40AF"; T="Bank" },
    @{ F="JournalEntry_32.png"; S=32; C="#475569"; T="Book" },
    @{ F="Supplier_32.png"; S=32; C="#7C3AED"; T="Users" },

    # --- Consulta de Movimientos ---
    @{ F="ProductSearch_32.png"; S=32; C="#2563EB"; T="Search" },
    @{ F="Kardex_32.png"; S=32; C="#EA580C"; T="Kardex" },
    @{ F="Reserved_16.png"; S=16; C="#D97706"; T="Box" },
    @{ F="InvoiceSearch_32.png"; S=32; C="#1D4ED8"; T="Search" },
    @{ F="ClientSales_16.png"; S=16; C="#2563EB"; T="Users" },
    @{ F="AccountStatement_16.png"; S=16; C="#0D9488"; T="Doc" },
    @{ F="ClientTx_16.png"; S=16; C="#2563EB"; T="Arrows" },
    @{ F="SupplierStatement_32.png"; S=32; C="#7C3AED"; T="Doc" },
    @{ F="SupplierTx_16.png"; S=16; C="#7C3AED"; T="Arrows" },
    @{ F="Reconciliation_32.png"; S=32; C="#0D9488"; T="Bank" },
    @{ F="BankBalances_16.png"; S=16; C="#1E40AF"; T="Bank" },
    @{ F="JournalSearch_16.png"; S=16; C="#475569"; T="Search" },

    # --- Reportes ---
    @{ F="ReportSales_32.png"; S=32; C="#2563EB"; T="Chart" },
    @{ F="TopProducts_16.png"; S=16; C="#F59E0B"; T="Chart" },
    @{ F="ClientBalances_16.png"; S=16; C="#2563EB"; T="Users" },
    @{ F="AgingReport_32.png"; S=32; C="#DC2626"; T="Chart" },
    @{ F="ReportStock_32.png"; S=32; C="#4338CA"; T="Box" },
    @{ F="StockTurnover_16.png"; S=16; C="#0D9488"; T="Arrows" },
    @{ F="StockAging_16.png"; S=16; C="#DC2626"; T="Chart" },
    @{ F="StockMovement_16.png"; S=16; C="#0284C7"; T="Box" },
    @{ F="Catalog_16.png"; S=16; C="#7C3AED"; T="Book" },
    @{ F="SuggestedPurchase_32.png"; S=32; C="#16A34A"; T="BoxIn" },
    @{ F="POReport_16.png"; S=16; C="#D97706"; T="Doc" },
    @{ F="InboundReport_16.png"; S=16; C="#16A34A"; T="Doc" },
    @{ F="TransferReport_32.png"; S=32; C="#0284C7"; T="Transfer" },
    @{ F="AdjustmentReport_32.png"; S=32; C="#475569"; T="Sliders" },

    # --- Contabilidad ---
    @{ F="GeneralLedger_32.png"; S=32; C="#1E293B"; T="Book" },
    @{ F="TrialBalance_32.png"; S=32; C="#B45309"; T="Chart" },
    @{ F="SubLedger_16.png"; S=16; C="#334155"; T="Book" },
    @{ F="FinancialStatements_16.png"; S=16; C="#047857"; T="Doc" },
    @{ F="AccountHistory_16.png"; S=16; C="#475569"; T="Arrows" },
    @{ F="BankTx_32.png"; S=32; C="#1E40AF"; T="Bank" },
    @{ F="CreditCard_32.png"; S=32; C="#4338CA"; T="Cash" },
    @{ F="SupplierOverdue_32.png"; S=32; C="#991B1B"; T="DocAlert" },
    @{ F="SupplierBalances_16.png"; S=16; C="#7C3AED"; T="Users" },

    # --- Sistema y Mantenimiento ---
    @{ F="Clients_32.png"; S=32; C="#2563EB"; T="Users" },
    @{ F="Products_32.png"; S=32; C="#0284C7"; T="Box" },
    @{ F="Suppliers_32.png"; S=32; C="#7C3AED"; T="Users" },
    @{ F="ChartAccounts_16.png"; S=16; C="#475569"; T="Sliders" },
    @{ F="Directory_16.png"; S=16; C="#D97706"; T="Book" },
    @{ F="AssignPhotos_16.png"; S=16; C="#7C3AED"; T="DocAdd" },
    @{ F="Settings_32.png"; S=32; C="#475569"; T="Sliders" },
    @{ F="GeneralSettings_16.png"; S=16; C="#2563EB"; T="Sliders" },
    @{ F="StockSettings_16.png"; S=16; C="#D97706"; T="Sliders" },
    @{ F="SalesSettings_16.png"; S=16; C="#16A34A"; T="Sliders" },
    @{ F="AddUser_32.png"; S=32; C="#2563EB"; T="Users" }
)

# 3. Función de renderizado lineal
function Build-Icon($item) {
    $sz = $item.S
    $bmp = New-Object System.Drawing.Bitmap $sz, $sz
    $gfx = [System.Drawing.Graphics]::FromImage($bmp)
    $gfx.SmoothingMode = [System.Drawing.Drawing2D.SmoothingMode]::AntiAlias
    $gfx.Clear([System.Drawing.Color]::Transparent)

    $color = [System.Drawing.ColorTranslator]::FromHtml($item.C)
    $brush = New-Object System.Drawing.SolidBrush($color)
    $pen = New-Object System.Drawing.Pen($color, 1.2)
    $penWhite = New-Object System.Drawing.Pen([System.Drawing.Color]::White, 1.5)

    if ($sz -eq 32) {
        # Base de tarjeta con fondo suave
        $gfx.FillRectangle((New-Object System.Drawing.SolidBrush([System.Drawing.Color]::FromArgb(248, 250, 252))), 4, 3, 24, 26)
        $gfx.DrawRectangle($pen, 4, 3, 24, 26)
        $gfx.FillRectangle($brush, 4, 3, 24, 7)

        # Glifos principales
        if ($item.T -eq "Chart") {
            $gfx.FillRectangle($brush, 7, 18, 4, 8)
            $gfx.FillRectangle($brush, 14, 14, 4, 12)
            $gfx.FillRectangle($brush, 21, 11, 4, 15)
        }
        elseif ($item.T -eq "Users") {
            $gfx.FillEllipse($brush, 12, 11, 8, 8)
            $gfx.FillPie($brush, 8, 19, 16, 12, 180, 180)
        }
        elseif ($item.T -eq "Box" -or $item.T -eq "BoxIn") {
            $gfx.FillRectangle($brush, 8, 12, 16, 13)
            $gfx.DrawLine($penWhite, 8, 17, 24, 17)
            if ($item.T -eq "BoxIn") {
                $gfx.FillPolygon((New-Object System.Drawing.SolidBrush([System.Drawing.Color]::FromArgb(22, 163, 74))), @(
                    (New-Object System.Drawing.PointF 16, 21),
                    (New-Object System.Drawing.PointF 12, 15),
                    (New-Object System.Drawing.PointF 20, 15)
                ))
            }
        }
        elseif ($item.T -eq "Bank" -or $item.T -eq "Cash") {
            $gfx.FillRectangle($brush, 7, 13, 18, 12)
            $gfx.DrawLine($penWhite, 10, 19, 22, 19)
        }
        elseif ($item.T -eq "Search") {
            $gfx.DrawEllipse((New-Object System.Drawing.Pen($color, 2.0)), 9, 12, 8, 8)
            $gfx.DrawLine((New-Object System.Drawing.Pen($color, 2.2)), 16, 19, 22, 25)
        }
        else {
            # Documento estándar y variantes
            $gfx.DrawLine((New-Object System.Drawing.Pen([System.Drawing.Color]::FromArgb(148, 163, 184), 1.5)), 8, 14, 20, 14)
            $gfx.DrawLine((New-Object System.Drawing.Pen([System.Drawing.Color]::FromArgb(148, 163, 184), 1.5)), 8, 18, 22, 18)
            $gfx.DrawLine((New-Object System.Drawing.Pen([System.Drawing.Color]::FromArgb(148, 163, 184), 1.5)), 8, 22, 16, 22)
            if ($item.T -eq "DocAdd") {
                $gfx.FillEllipse((New-Object System.Drawing.SolidBrush([System.Drawing.Color]::FromArgb(22, 163, 74))), 17, 17, 12, 12)
                $gfx.DrawLine($penWhite, 23, 20, 23, 26)
                $gfx.DrawLine($penWhite, 20, 23, 26, 23)
            }
        }
    }
    else {
        # Íconos de 16x16
        $gfx.FillRectangle($brush, 2, 2, 12, 12)
        $gfx.DrawRectangle((New-Object System.Drawing.Pen([System.Drawing.Color]::FromArgb(15, 23, 42), 0.8)), 2, 2, 12, 12)
        $gfx.DrawLine($penWhite, 4, 6, 12, 6)
        $gfx.DrawLine($penWhite, 4, 9, 10, 9)
    }

    # Guardado seguro en disco
    $fullPath = [System.IO.Path]::Combine($targetFolder, $item.F)
    if (Test-Path -LiteralPath $fullPath) {
        Remove-Item -LiteralPath $fullPath -Force -ErrorAction SilentlyContinue
    }

    $stream = New-Object System.IO.FileStream($fullPath, [System.IO.FileMode]::Create, [System.IO.FileAccess]::Write)
    $bmp.Save($stream, [System.Drawing.Imaging.ImageFormat]::Png)
    $stream.Close()
    $stream.Dispose()

    $gfx.Dispose()
    $bmp.Dispose()
}

# 4. Procesamiento
Write-Host "Generando 64 iconos..." -ForegroundColor Yellow
$i = 0
foreach ($entry in $iconList) {
    $i++
    Build-Icon $entry
    Write-Host ("[{0,2}/64] -> {1}" -f $i, $entry.F) -ForegroundColor Green
}

Write-Host "`n¡Completado con éxito! Las 64 imágenes están listas en Images\Ribbon\" -ForegroundColor Cyan