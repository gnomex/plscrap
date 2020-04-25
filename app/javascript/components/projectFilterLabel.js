import React from 'react';

const ProjectFilterLabel = ({ quantity }) => {
  let message = `Exibindo ${quantity} resultados`

  if (quantity === 0) message = "Nenhum projeto encontrado"

  return (
    <p className="text-muted">{message}</p>
  );
}

export default ProjectFilterLabel;
