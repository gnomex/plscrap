import React from 'react';

const Pagination = ({ prevPage, nextPage, pagination }) => {
  if (pagination.total_pages === 1) return null;

  return (
    <div className="container mb-5 px-0">
      <div className="d-flex align-items-end flex-column">
        <div className="mb-auto">
          <p className="">página {pagination.page} de {pagination.total_pages} </p>
        </div>

        <div className="mt-auto">
          <button type="button" className="btn btn-outline-primary" disabled={pagination.page === 1} onClick={ prevPage }> Anterior </button>

          <button type="button" className="btn btn-outline-primary" disabled={pagination.page === pagination.total_pages} onClick={ nextPage }> Próxima </button>
        </div>
      </div>
    </div>
  )
}

export default Pagination;
