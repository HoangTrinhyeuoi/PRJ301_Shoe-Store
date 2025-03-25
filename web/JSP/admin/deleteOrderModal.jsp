<%@page contentType="text/html" pageEncoding="UTF-8"%>



<div class="modal fade" id="delete-order-modal" tabindex="-1" aria-labelledby="deleteOrderModalLabel" aria-hidden="true">
    <div class="modal-dialog modal-dialog-centered">
        <div class="modal-content border-0">
            <div class="modal-header bg-danger text-white">
                <h5 class="modal-title" id="deleteOrderModalLabel">
                    <i class="bi bi-exclamation-triangle-fill"></i> Confirm Order Deletion
                </h5>
                <button type="button" class="btn-close btn-close-white" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            <form id="delete-order-form" action="admin/order?action=delete" method="post">
                <div class="modal-body text-center">
                    <input type="hidden" id="delete-order-id" name="id" />
                    <p class="fs-5 mb-3 text-danger">
                        Are you sure you want to delete this order?
                    </p>
                    <p id="delete-order-info" class="fw-bold"></p>
                </div>
                <div class="modal-footer border-0 justify-content-center">
                    <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Cancel</button>
                    <button type="submit" class="btn btn-danger">Delete</button>
                </div>
            </form>
        </div>
    </div>
</div>

<script>
    function deleteOrderModal(orderId) {
        document.getElementById('delete-order-id').value = orderId;
        document.getElementById('delete-order-info').innerText = 'Order ID: ' + orderId;
        const modal = new bootstrap.Modal(document.getElementById('delete-order-modal'));
        modal.show();
    }
</script>
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.5/font/bootstrap-icons.css">
